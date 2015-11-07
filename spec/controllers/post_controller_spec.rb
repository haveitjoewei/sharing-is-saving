require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::TestHelpers

  describe "factory user" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

	it "should post an item" do
		@post = FactoryGirl.build(:post)
    	response = post :create, {post: @post.attributes}
   		expect(response.status).to eq(302)
	end

	it "should get all items" do
		@post = FactoryGirl.build(:post)
    	post :create, {post: @post.attributes}
    	response = get :index
    	expect(response.status).to eq(200)
    	expect(controller.instance_variable_get(:@allPosts).length).to eq(1)

   		@post = FactoryGirl.build(:post)
    	post :create, {post: @post.attributes}
    	response = get :index
    	expect(response.status).to eq(200)
    	expect(controller.instance_variable_get(:@allPosts).length).to eq(2)
	end

	# it "should get item with status 2" do
	# 	@post = FactoryGirl.build(:post)
 #    	post :create, {post: @post.attributes}
 #    	response = get :index, 
 #    	expect(response.status).to eq(200)
 #    	expect(controller.instance_variable_get(:@allPosts).length).to eq(1)

	# end

  end

end
