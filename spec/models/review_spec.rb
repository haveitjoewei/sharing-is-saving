require 'rails_helper'

RSpec.describe Review, type: :model do
	it "has a valid factory" do
		FactoryGirl.create(:review).should be_valid
	end
	it "is invalid without a reviewer_id" do
		FactoryGirl.build(:review, reviewer_id: nil).should_not be_valid
	end
	it "is invalid without a lender_id" do
		FactoryGirl.build(:review, lender_id: nil).should_not be_valid
	end
	it "is invalid without a exchange_id" do
		FactoryGirl.build(:review, exchange_id: nil).should_not be_valid
	end
	it "is invalid without a rating" do
		FactoryGirl.build(:review, rating: nil).should_not be_valid
	end
	it "is invalid without a content" do
		FactoryGirl.build(:review, content: nil).should_not be_valid
	end
end
