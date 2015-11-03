class Api::V1::Reviews::ReviewController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:show, :index, :destroy]
	skip_before_filter :authenticate_user_from_token!, :only => [:show, :index, :destroy]
	respond_to :json

	#POST /api/v1/reviews(.:format) 
	#Creates review
	def create
		@user = current_user
		@review = ::Review.new(review_params.merge!(reviewer_id: @user.id))
		#get lender_id from exchange
		#check if exchange exists
		#handle case if review already exists
		#shouldn't be able to write review if exchange.lender = user
		if @review.save
			newReview = update_created_and_updated_at(@review)
			render :json => {:status => 1, :exchange => newReview}
		else
			render :json => {:status => '-1', :errors => @review.errors.full_messages}, :status => 404
		end
	end

	#GET /api/v1/reviews(.:format) 
	#Shows all reviews
	def index
		@allReviews = ::Review.all.order(:created_at).reverse_order
		reviewArray = Array.new
		@allReviews.each do |review|
			newReview = update_created_and_updated_at(review)
			reviewArray.push newReview
		end
		render :json => {:status => 1, :exchange => reviewArray}
	end

	#GET /api/v1/reviews/:id(.:format)
	def show
	end

	#/api/v1/reviews/:id(.:format)
	def destroy
	end

	def update
	end

	private
	def review_params
		params.require(:review).permit(:exchange_id, :rating, :review)	
	end

	def update_created_and_updated_at(exchange)
		newExchange = ActiveSupport::JSON.decode exchange.to_json
		newExchange['created_at'] = exchange.created_at.to_f
		newExchange['updated_at'] = exchange.updated_at.to_f
		return newExchange
	end
end