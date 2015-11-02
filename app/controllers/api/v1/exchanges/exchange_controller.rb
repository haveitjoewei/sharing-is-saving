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

		@exchange = ::Exchange.new(post: @post, lender: @lender, borrower: @borrower, status: 1)

		if @exchange.save
			newExchange = ActiveSupport::JSON.decode @exchange.to_json
			newExchange['created_at'] = @exchange.created_at.to_f
			newExchange['updated_at'] = @exchange.updated_at.to_f
			render :json => {:status => 1, :exchange => newExchange}
		else
			render :json => {:status => '-1', :errors => @exchange.errors.full_messages}, :status => 404
		end
	end


	# GET /api/v1/exchanges(.:format)
	# Gets all posts
	def index
		#response.headers['Access-Control-Allow-Origin'] = "*"# * means any. specify to 

		@allExchanges = ::Exchange.all.order(:created_at).reverse_order
		exchangeArray = Array.new
		@allExchanges.each do |exchange|
			newExchange = ActiveSupport::JSON.decode exchange.to_json
			newExchange['created_at'] = exchange.created_at.to_f
			newExchange['updated_at'] = exchange.updated_at.to_f
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
			render :json => {:status => -1, :message => "Couldn't find exchange because exchange does not exist." }, :status => 404
		else
			newExchange = ActiveSupport::JSON.decode @oneExchange.to_json
			newExchange['created_at'] = @oneExchange.created_at.to_f
			newExchange['updated_at'] = @oneExchange.updated_at.to_f
			render :json => {:status => 1, :post => newExchange}
		end
	end

	# DELETE /api/v1/exchanges/:id(.:format)  
	def destroy
		begin
			@exchange = ::Exchange.find(params[:id])
		rescue
			ActiveRecord::RecordNotFound
			render :json => {:status => -1, :message => "Couldn't delete exchange because post does not exist." }, :status => 404
		else
			::Exchange.delete(params[:id])
			render :json => {:status => 1}
		end
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
end
