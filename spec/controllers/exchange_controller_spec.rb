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

    it "should make a request for an exchange" do
    	post :create, { post_id: @post.id }
		expect(response.status).to eq(200)
  end

end
