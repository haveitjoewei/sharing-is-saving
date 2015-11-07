require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ApplicationController, type: :controller do
  include Devise::TestHelpers

  before :each do
    @borrower = FactoryGirl.create(:user)
    @lender = FactoryGirl.create(:user2)
    @post = FactoryGirl.create(:post, :user => @lender)
    @exchange = FactoryGirl.create(:exchange)
    sign_in @borrower
    allow(controller).to(receive(:current_user).and_return(@borrower))
  end

  # This should return the minimal set of attributes required to create a valid
  # Activity. As you add validations to Activity, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {
      trackable_id:  1,
      trackable_type: 'Exchange',
      owner_id: @borrower.id,
      owner_type: 'User',
      key: 'exchange.update_status',
      parameters: {},
      recipient_id: @lender.id,
      recipient_type: 'User',
      post_id: @post.id,
      exchange_id: @exchange.id,
      created_at: Date.today,
      updated_at: Date.today
  } }

  describe "GET #notifications" do
    it "should get our notifications" do
      activity = PublicActivity::Activity.create! valid_attributes
      
      get :home
      expect(response.status).to eq(200)
    end
  end

end
