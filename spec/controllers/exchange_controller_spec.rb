require 'rails_helper'

RSpec.describe ExchangesController, type: :controller do
  include Devise::TestHelpers

  describe "factory user" do
    before :each do
      @borrower = FactoryGirl.create(:user)
      @lender = FactoryGirl.create(:user2)
      @third_party = FactoryGirl.create(:user3)
      @post = FactoryGirl.create(:post, :user => @lender)
      sign_in @borrower
    end

    it "should make a request for an exchange and test showing it" do
    	response = post :create, { post_id: @post.id }
		expect(response.status).to eq(200)
		@createdExchange= controller.instance_variable_get(:@exchange)

		# Show created Exchange
		response2 = get :show, { id: @createdExchange.id }
		expect(response2.status).to eq(200)
	end

    it "should not be able to find an exchange that doesn't exist" do
		response2 = get :show, { id: 5}
		expect(response2.status).to eq(404)
	end

    it "should not be able to access an exchange that it does not have access to" do
    	response = post :create, { post_id: @post.id }
		expect(response.status).to eq(200)
		@createdExchange= controller.instance_variable_get(:@exchange)

		sign_out @borrower
		sign_in @third_party

		response2 = get :show, { id: @createdExchange.id}
		expect(response2.status).to eq(404)
	end

    it "should be able to get all exchanges" do
    	response = post :create, { post_id: @post.id }
		expect(response.status).to eq(200)
		@createdExchange= controller.instance_variable_get(:@exchange)

		response2 = get :index
		expect(response2.status).to eq(200)

		response3 = get :index, { filter: 'lender' }
		expect(response3.status).to eq(200)

		response4 = get :index, { filter: 'borrower' }
		expect(response4.status).to eq(200)

		response4 = get :index, { filter: 'wrong_name' }
		expect(response4.status).to eq(404)
	end

    it "should update status for an exchange" do
    	response = post :create, { post_id: @post.id }
		expect(response.status).to eq(200)
		@createdExchange= controller.instance_variable_get(:@exchange)

		response2 = put :update_status, { id: @createdExchange.id, status: 2 }
		expect(response2.status).to eq(200)

		response2 = put :update_status, { id: @createdExchange.id, status: 2 }
		expect(response2.status).to eq(404)

		response2 = put :update_status, { id: @createdExchange.id, status: 3 }
		expect(response2.status).to eq(200)

		response2 = put :update_status, { id: @createdExchange.id, status: 4 }
		expect(response2.status).to eq(200)

		response2 = put :update_status, { id: @createdExchange.id, status: 5 }
		expect(response2.status).to eq(200)

		response2 = put :update_status, { id: @createdExchange.id, status: 6 }
		expect(response2.status).to eq(404)

		response2 = put :update_status, { id: @createdExchange.id, status: 1 }
		expect(response2.status).to eq(404)

		response2 = put :update_status, { id: @createdExchange.id, status: 'a' }
		expect(response2.status).to eq(404)

		response2 = put :update_status, { id: 555, status: 1 }
		expect(response2.status).to eq(404)

		@modifiedExchange= controller.instance_variable_get(:@exchange)
		expect(@modifiedExchange.status == 2)

	end

    it "should get all statuses" do
    	response = get :statuses
		expect(response.status).to eq(200)
	end

    it "should fail trying to make the exchange twice" do
    	response = post :create, { post_id: @post.id }
		expect(response.status).to eq(200)
    	response2 = post :create, { post_id: @post.id }
		expect(response2.status).to eq(404)
	end

  end

end
