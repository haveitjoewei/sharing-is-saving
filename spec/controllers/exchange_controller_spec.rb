require 'rails_helper'

RSpec.describe ExchangesController, type: :controller do
  include Devise::TestHelpers

  describe "factory user" do
    before :each do
      @borrower = FactoryGirl.create(:user)
      @lender = FactoryGirl.create(:user2)
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

    it "should update status for an exchange" do
    	response = post :create, { post_id: @post.id }
		expect(response.status).to eq(200)
		@createdExchange= controller.instance_variable_get(:@exchange)

		response2 = put :update_status, { id: @createdExchange.id, status: 2 }
		expect(response2.status).to eq(200)

		@modifiedExchange= controller.instance_variable_get(:@exchange)
		expect(@modifiedExchange.status == 2)

	end

  end

end
