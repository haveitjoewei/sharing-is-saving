class Api::V1::Exchanges::ExchangeController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:show, :index, :destroy]
	skip_before_filter :authenticate_user_from_token!, :only => [:show, :index, :destroy]
	respond_to :json
	# POST /api/v1/exchanges
	def create
		@borrower = current_user
		
		@post = ::Post.find(exchange_params[:post_id])

		if !@post
			return render_errors(['Post does not exist.'])
		end
		
		@lender = ::User.find(@post.user_id)
		if !@lender
			return render_errors(['Lender does not exist.'])
		end

		if @borrower.id == @lender.id
			return render_errors(["Borrower and lender cannot be the same."])
		end

		existingExchanges = ::Exchange.where(post: @post, lender: @lender, borrower: @borrower, status:1..2)
		if existingExchanges.count > 0
			ids = existingExchanges.collect(&:id).to_sentence
			return render_errors(["Transactions already exist for this specific post, lender, and borrower. Please delete them. The transaction ids are: #{ids}."])
		end

		@exchange = ::Exchange.new(post: @post, lender: @lender, borrower: @borrower, status: 1)

		if @exchange.save
			newExchange = update_created_and_updated_at(@exchange)
			render :json => {:status => 1, :exchange => newExchange}
		else
			render :json => {:status => '-1', :errors => @exchange.errors.full_messages}, :status => 404
		end
	end

	# GET /api/v1/exchanges(.:format)
	# Gets all posts
	def index
		@allExchanges = ::Exchange.all.order(:created_at).reverse_order
		exchangeArray = Array.new
		@allExchanges.each do |exchange|
			newExchange = update_created_and_updated_at(exchange)
			exchangeArray.push newExchange
		end
		render :json => {:status => 1, :exchange => exchangeArray}
	end

	# GET /api/v1/exchanges/:id(.:format)
	# Gets one post
	def show
		begin
			@oneExchange = ::Exchange.find(params[:id])
		rescue
			ActiveRecord::RecordNotFound
			return render_errors(["Couldn't find exchange because exchange does not exist."])
		else
			newExchange = update_created_and_updated_at(@oneExchange)
			render :json => {:status => 1, :exchange => newExchange}
		end
	end

	# DELETE /api/v1/exchanges/:id(.:format)  
	def destroy
		begin
			@exchange = ::Exchange.find(params[:id])
		rescue
			ActiveRecord::RecordNotFound
			return render_errors(["Couldn't delete exchange because post does not exist."])
		else
			::Exchange.delete(params[:id])
			render :json => {:status => 1}
		end
	end

	# PUT /api/v1/exchanges/:id/update_status
	def update_status
		@exchange = ::Exchange.find(params[:id])

		whats_available = "To query available statuses, call /api/v1/exchanges/statuses."

		begin
			status = Integer(params[:status])
		rescue ArgumentError
			return render_errors(["Status must be an integer. #{whats_available}"])
		end

		if !status.between?(1, 5)
			return render_errors(["Please pick a status from 1 to 5. #{whats_available}"])
		end

		status = params[:status].to_i

		if status == 1
			return render_errors(["Setting an exchange to 'Pending' is not allowed. #{whats_available}"])
		end

		if status == @exchange.status
			return render_errors(["The status of this exchange is already #{status}. #{whats_available}"])
		end

		post = ::Post.find(@exchange.post_id)

		if !post
			return render_errors(["The post that this exchange is linked to is invalid. The post that you linked to is #{post.id}."])
		end

		case status
			when 2 # Accepted
				post.update_attributes(:status => 2) # Assuming post status = 2 means it's borrowed
			when 3 # Rejected
				post.update_attributes(:status => 1) # Assuming post status = 1 means it's available
			when 4 # Completed
				post.update_attributes(:status => 1)
			when 5 # Completed
				post.update_attributes(:status => 1)
		end

		@exchange.update_attributes(:status => status)

		render :json => {:status => 1, :exchange => @exchange}

	end

	# GET /api/v1/exchanges/statuses
	# Gets all exchange statuses
	def statuses
		render :json => {:status => 1, :categories => {"1" => "Pending", "2" => "Accepted", "3" => "Rejected", "4" => "Completed", "5" => "Cancelled"}}, :status => 200
		return
	end

	private
		def exchange_params
			params.require(:exchange).permit(:post_id)
		end

		def update_created_and_updated_at(exchange)
			newExchange = ActiveSupport::JSON.decode exchange.to_json
			newExchange['created_at'] = exchange.created_at.to_f
			newExchange['updated_at'] = exchange.updated_at.to_f
			return newExchange
		end

end
