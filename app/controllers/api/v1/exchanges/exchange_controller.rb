class Api::V1::Exchanges::ExchangeController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:show, :index, :destroy]
	skip_before_filter :authenticate_user_from_token!, :only => [:show, :index, :destroy]
	respond_to :json
	#POST   /api/v1/exchanges(.:format)  
	def create
		# @user = User.find(post_params[]) #borrower
		# @user = User.find() #lender
		# @post = Post.find() #post
		#response.headers['Access-Control-Allow-Origin'] = "*"# * means any. specify to 
		
		@borrower = current_user
		if @borrower
			@post = ::Post.where(id: params[:post_id]).first
			#handle error if not found
			@lender = ::User.where(id: @post.user_id).first
			#handle error if not found
			@exchange = Exchange.new(post_id: @post.id ,lender_id: @lender.id ,borrower_id: @borrower.id)
			respond_to do |format|
				format.json {
					if @exchange.save
						newExchange = ActiveSupport::JSON.decode @exchange.to_json
						newExchange['created_at'] = @exchange.created_at.to_f
						newExchange['updated_at'] = @exchange.updated_at.to_f
						render :json => {'status' => 1, 'exchange' => newExchange}
					else
						render :json => { :status => '-1', :message => 'Exchange errors' }, :status => 404 #@post.errors.full_messages
					end
				}
			end
		else
			render :json => { :status => '-1', :message => 'Couldn\'t create transaction because token is invalid.' }, :status => 404
		end
	end


	#GET    /api/v1/exchanges(.:format) 
	#gets all posts
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

	#GET    /api/v1/exchanges/:id(.:format)
	#gets one post
	def show
		#response.headers['Access-Control-Allow-Origin'] = "*"# * means any. specify to 
		begin
			@oneExchange = ::Exchange.find(params[:id])
		rescue
			ActiveRecord::RecordNotFound
			render :json => {:status => -1, :message => 'Couldn\'t find exchange because exchange does not exist.' }, :status => 404
		else
			newExchange = ActiveSupport::JSON.decode @oneExchange.to_json
			newExchange['created_at'] = @oneExchange.created_at.to_f
			newExchange['updated_at'] = @oneExchange.updated_at.to_f
			render :json => {:status => 1, :post => newExchange}
		end
	end

	#DELETE /api/v1/exchanges/:id(.:format)  
	def destroy
		begin
			@exchange = ::Exchange.find(params[:id])
		rescue
			ActiveRecord::RecordNotFound
			render :json => {:status => -1, :message => 'Couldn\'t delete exchange because post does not exist.' }, :status => 404
		else
			::Exchange.delete(params[:id])
			render :json => {:status => 1}
		end
	end


	# private
	# 	def exchange_params
	# 		params.require(:exchange).permit(:borrower)
	# 	end
end
