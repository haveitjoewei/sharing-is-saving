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
		#filter by reviewer
		if params.has_key?(:reviewer_id)
			@allReviews = @allReviews.where("reviewer_id = ?", params[:reviewer_id])
			#error: if doesnt exist
		end
		#filter by post?
		#filter by lender

		reviewArray = Array.new
		@allReviews.each do |review|
			newReview = update_created_and_updated_at(review)
			reviewArray.push newReview
		end
		render :json => {:status => 1, :review => reviewArray}
	end

	#GET /api/v1/reviews/:id(.:format)
	#Show one review
	def show
		begin
			@oneReview = ::Review.find(params[:id])
		rescue
			ActiveRecord::RecordNotFound
			return render_errors(["Couldn't find review because review does not exist."])
		else
			newReview = update_created_and_updated_at(@oneReview)
			render :json => {:status => 1, :review => newReview}
		end
	end

	#DELETE /api/v1/reviews/:id(.:format)
	#Delete one review
	def destroy
		begin
			@review = ::Review.find(params[:id])
		rescue
			ActiveRecord::RecordNotFound
			return render_errors(["Couldn't delete review because review does not exist."])
		else
			::Review.delete(params[:id])
			render :json => {:status => 1}
		end
	end

	#PATCH /api/v1/exchanges/:id(.:format)  
	#Updates one review
	def update
		begin
			@review = ::Review.find(params[:id])
		rescue
			return render_errors(['No review found.'])
		end

		if @review.reviewer_id == current_user.id # check for permission
			if @review.update_attributes(review_patch_params)
				newReview = update_created_and_updated_at(@review)
				render :json => {:status => 1, review: newReview}, :status => 200
				return 
			else
				return render_errors(["Updating review failed."])
			end
		else
			return render_errors(["User does not have permissions to update this review."])
		end
	end

	private
	def review_params
		params.require(:review).permit(:lender_id, :exchange_id, :rating, :review)	
	end

	def review_patch_params
		params.require(:review).permit(:rating, :review)	
	end

	def update_created_and_updated_at(review)
		newReview = ActiveSupport::JSON.decode review.to_json
		newReview['created_at'] = review.created_at.to_f
		newReview['updated_at'] = review.updated_at.to_f
		return newReview
	end
end