require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
	include Devise::TestHelpers

	describe "factory user" do
	before :each do
	  @borrower = FactoryGirl.create(:user)
	  @borrower.save!
	  @lender = FactoryGirl.create(:user2)
	  @lender.save!
	  @post = FactoryGirl.create(:post, :user => @lender)
	  @post.save!
	  @exchange = FactoryGirl.create(:exchange, :post => @post)
	  @exchange.save!
	  @review = FactoryGirl.create(:review, :exchange => @exchange)
	  @review.save!
	  sign_in @borrower
	end

	it "should make a request to new" do
		response = get :new, "reviews"=>{ exchange_id: @exchange.id }
		expect(response.status).to eq(200)
		@createdReview= controller.instance_variable_get(:@review)
	end

	it "should make a request to create an review" do
		response = post :create, "reviews"=>{ exchange_id: @exchange.id, rating: 1, content: "great!" }
		expect(response.status).to eq(302)
		@createdReview= controller.instance_variable_get(:@review)
	end

	# it "should make a request to create an review created by borrower and error" do
	# 	@exchange.update_attribute(:lender_id, @borrower.id)
	# 	response = post :create, "reviews"=>{ exchange_id: @exchange.id, rating: 1, content: "great!" }
	# 	expect(response.status).to eq(404)
	# 	@createdReview= controller.instance_variable_get(:@review)
	# end

	it "should make a request to create a bad_review and error" do
		@exchange.update_attribute(:lender_id, 1)
		response = post :create, "reviews"=>{ exchange_id: @exchange.id, rating: 1, content: "great!" }
		expect(response.status).to eq(404)
		@createdReview= controller.instance_variable_get(:@review)
	end

	it "should make a request to show a review" do
		# Show created Exchange
		response = get :show, { id: @review.id }
		expect(response.status).to eq(200)
	end

	it "should make a request to show a review and get an error" do
		response = get :show, { id: 0 }
		expect(response.status).to eq(404)
	end

	it "should make a request to index all reviews" do
		response = get :index
		expect(response.status).to eq(200)
	end

	it "should make a request to index all reviews" do
		response = get :index, { reviewer_id: @borrower.id }
		expect(response.status).to eq(200)
	end

	it "should delete a request" do
		response = delete :destroy, { id: @review.id }
		expect(response.status).to eq(200)
	end

	it "should delete a request that can't be found and error" do
		response = delete :destroy, { id: 0 }
		expect(response.status).to eq(404)
	end

	# it "should make an patch request to update a review" do
	# 	response = patch :update, { id: @review.id, rating: 5, content: "changed" }
	# 	expect(response.status).to eq(200)
	# end




	# end

	end
end
