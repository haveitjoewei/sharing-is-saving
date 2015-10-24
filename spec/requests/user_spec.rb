require 'rails_helper'
require 'factory_girl_rails'

describe "Users API" do
    
  sign_up_endpoint = "/api/v1/users"
  sign_in_endpoint = "/api/v1/users/sign_in"

  email = "sidwyn@gmail.com"
  password = "password"
  password_confirmation = "password"
  first_name = "Sidwyn"
  last_name = "Koh"
  date_of_birth = "1992-03-19"
  latitude = 37.864490
  longitude = -122.254504

  describe "POST /api/v1/users" do

    # The following test creates a user in the database.

    it "signs up a user and then tries to log in as that user" do

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

      # General expectations
      expect(user['id']).to be > 0
      expect(user['email']).to eq(email)
      expect(user['first_name']).to eq(first_name)
      expect(user['last_name']).to eq(last_name)
      expect(user['date_of_birth']).to be_a(String) # TODO: Sidwyn to fix in future iteration
      expect(user['latitude']).to eq(latitude.to_s)
      expect(user['longitude']).to eq(longitude.to_s)

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

    end

    # The following test tries to create a user, but does not have first_name.

    it "signs up a user without a first name" do

      post sign_up_endpoint, 
      :user => {
        :email => email, 
        :password => password, 
        :password_confirmation => password_confirmation, 
        :last_name => last_name, 
        :date_of_birth => date_of_birth, 
        :latitude => latitude, 
        :longitude => longitude}

      # Basic check to expect response to be 200
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      status = body['status']
      
      # Expect status = 1
      expect(status).to eq(-1)

    end

  end

end