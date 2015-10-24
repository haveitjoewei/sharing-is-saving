require 'rails_helper'
require 'factory_girl_rails'

describe "Post API" do

  sign_up_endpoint = "/api/v1/users"
  sign_in_endpoint = "/api/v1/users/sign_in"
  get_all_items_endpoint = "/api/v1/posts"
  post_item_endpoint = "/api/v1/posts"
  get_delete_item_endpoint = "/api/v1/posts"
  x_api_token = ""
  x_api_email = ""

  # Set up a default user by signing up and logging in before any of the methods below run
  before(:each) do
      email = "sidwyn@gmail.com"
      password = "password"
      password_confirmation = "password"
      first_name = "Sidwyn"
      last_name = "Koh"
      date_of_birth = "1992-03-19"
      latitude = 37.864490
      longitude = -122.254504

      post sign_up_endpoint, 
      :user => {
        :email => email, 
        :password => password, 
        :password_confirmation => password_confirmation, 
        :first_name => first_name, 
        :last_name => last_name, 
        :date_of_birth => date_of_birth, 
        :latitude => latitude, 
        :longitude => longitude},
      :format => :json

      
      # Basic check to expect response to be 200
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      status = body['status']
      user = body['user']
      
      # Expect status = 1
      expect(status).to eq(1)

      # Log in here
      post sign_in_endpoint,
        :format => :json,
        :email => email, 
        :password => password

      # Basic check to expect response to be 201
      expect(response.status).to eq 201

      body = JSON.parse(response.body)
      status = body['status']
      user = body['user']
      
      # Expect status = 1
      expect(status).to eq(1)

      # General expectations
      expect(user['email']).to eq(email)
      expect(user['auth_token']).to be_a(String)

      # Set up auth token for future use
      x_api_email = user['email']
      x_api_token = user['auth_token']
  end

  # This method gets all the posts
  describe "GET /api/v1/posts" do
    it "returns all the posts" do
      FactoryGirl.create :post, title: "example title1", latitude: 123.45, longitude: 234.56, description: "example description 1", price: 12.34, security_deposit: 56.78, status: 1
      FactoryGirl.create :post, title: "example title2", latitude: 234.56, longitude: 123.45, description: "example description 2", price: 12.34, security_deposit: 56.78, status: 1

      get get_all_items_endpoint, :format => :json

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      post_titles = body['post'].map{ |m| m["title"] }
      expect(post_titles).to match_array(["example title1",
                                           "example title2"])

      post_latitude = body['post'].map{ |m| m["latitude"] }
      expect(post_latitude).to match_array([123.45,
                                           234.56])

      post_descriptions = body['post'].map{ |m| m["description"] }
      expect(post_descriptions).to match_array(["example description 1",
                                           "example description 2"])
    end
  end

  # This method makes a post with the saved user and then tries to delete it
  describe "POST /api/v1/posts" do
    it "creates a post and tries to retrieve it, and then tries to delete it" do
      title = "example title 3"
      latitude = 123.456
      longitude = 2345.67
      description = "example description 3"
      price = 12.34
      security_deposit = 56.89
      status = 1

      post_params = {
        "post" => {
            "title" => title,
            "latitude" => latitude,
            "longitude" => longitude,
            "description" => description, 
            "price" => price,
            "security_deposit" => security_deposit,
            "status" => status
            }
        }.to_json

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "X-API-TOKEN" => x_api_token,
        "X-API-EMAIL" => x_api_email
      }

      post post_item_endpoint, post_params, request_headers

      expect(response.status).to eq 201

      body = JSON.parse(response.body)
      status = body['status']
      post = body['post']

      expect(post['title']).to eq(title)
      expect(post['latitude']).to eq(latitude)
      expect(post['id']).to be > 0

      post_id_str = post['id'].to_s

      # Retrieving same post again
      get_delete_item_endpoint += '/' + post_id_str

      get get_delete_item_endpoint, {}, request_headers

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      status = body['status']
      post = body['post']
      
      expect(post['title']).to eq(title)
      expect(post['latitude']).to eq(latitude)
      expect(post['id'].to_s).to eq(post_id_str)

      # Destroying the same post
      delete get_delete_item_endpoint, {}, request_headers

      expect(response.status).to eq 200

    end
  end

end