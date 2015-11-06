require 'rails_helper'

RSpec.describe Exchange, type: :model do
	it "has a valid factory" do
		FactoryGirl.create(:exchange).should be_valid
	end
	it "is invalid without a lender_id" do
		FactoryGirl.build(:exchange, lender_id: nil).should_not be_valid
	end
	it "is invalid without a borrower_id" do
		FactoryGirl.build(:exchange, borrower_id: nil).should_not be_valid
	end
	it "is invalid without a post_id" do
		FactoryGirl.build(:exchange, post_id: nil).should_not be_valid
	end
	it "is invalid without a status" do
		FactoryGirl.build(:exchange, status: nil).should_not be_valid
	end
end
