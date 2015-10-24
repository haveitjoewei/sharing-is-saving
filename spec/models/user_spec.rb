require 'rails_helper'
require 'factory_girl_rails'
# http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html

describe User do
	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end
	it "is invalid without a email" do
		FactoryGirl.build(:user, email: nil).should_not be_valid
	end
	it "is invalid without a first_name" do
		FactoryGirl.build(:user, first_name: nil).should_not be_valid
	end
	it "is invalid without a last_name" do
		FactoryGirl.build(:user, last_name: nil).should_not be_valid
	end
end