require 'rails_helper'

RSpec.describe ExchangesController, type: :controller do
  include Devise::TestHelpers

  describe "factory user" do
    before :each do
      @ma_user = FactoryGirl.create(:user)
      @ma_user2 = FactoryGirl.create(:user2)
      @post = FactoryGirl.create(:post)
      sign_in @ma_user
      byebug
    end

    it "should make a request for an exchange" do
      byebug
      post :create, { id: @post.id }
      expect( response ).to redirect_to( new_user_session_path )
    end
  end

end
