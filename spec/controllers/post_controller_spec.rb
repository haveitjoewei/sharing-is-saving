require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::TestHelpers

  describe "factory user" do
    before :each do
      @user = FactoryGirl.create(:user)
      @user.save!
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

    it "should update the item" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      id = controller.instance_variable_get(:@post).id
      expect(controller.instance_variable_get(:@post).status).to eq(1)
      @post2 = FactoryGirl.build(:post2)
      put :update, {:id => id, post: @post2.attributes}
      expect(controller.instance_variable_get(:@post).status).to eq(2)
    end

    it "should get the item with status 2" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      response = get :index, {:status => 1}
      expect(response.status).to eq(200)
    end  

    it "should get the item within a region" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      response = get :index, {:center => "12.34, -93", :radius => 10}
      expect(response.status).to eq(200)
    end  

    it "should error with invalid latitude" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      response = get :index, {:center => "1233.34, -93", :radius => 10}
      expect(response.status).to eq(404)
    end  

    it "should error with invalid longitude" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      response = get :index, {:center => "133.34, -933", :radius => 10}
      expect(response.status).to eq(404)
    end          

    it "should error with invalid center" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      response = get :index, {:center => 12.34, :radius => 10}
      expect(response.status).to eq(404)
    end  

    it "should error with invalid parameters" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      response = get :index, {:center => "error", :radius => 10}
      expect(response.status).to eq(404)
    end  

    it "should get the item with category 1" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      response = get :index, {:category => 1}
      expect(response.status).to eq(200)
    end     

    it "should get the item associated with user 1" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      response = get :index, {:user => 1}
      expect(response.status).to eq(200)
    end      

    it "should create an item, then delete it" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      id = controller.instance_variable_get(:@post).id
      get :index
      expect(controller.instance_variable_get(:@allPosts).length).to eq(1)
      delete :destroy, {:id => id}
      get :index
      expect(controller.instance_variable_get(:@allPosts).length).to eq(0)
    end

    it "should error when trying to delete a nonexistent post" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      id = controller.instance_variable_get(:@post).id
      get :index
      expect(controller.instance_variable_get(:@allPosts).length).to eq(1)
      response = delete :destroy, {:id => 3}
      expect(response.status).to eq(404)
    end    

    it "should show one item" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      id = controller.instance_variable_get(:@post).id      
      get :index
      expect(controller.instance_variable_get(:@allPosts).length).to eq(1)
      get :show, {:id => id}
      expect(controller.instance_variable_get(:@post).id).to eq(id)
    end

    it "should show zero items" do
      @post = FactoryGirl.build(:post)
      post :create, {post: @post.attributes}
      response = get :show, {:id => 3}
      expect(response.status).to eq(404)
    end    

    it "should return all cateogires" do
      response = get :categories
      expect(response.status).to eq(200)
    end


    it "should check statuses" do
      response = get :statuses
      expect(response.status).to eq(200)
    end
  end

end
