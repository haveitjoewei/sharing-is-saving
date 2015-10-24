require 'rails_helper'
require 'factory_girl_rails'
# http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html

describe Post do
	it "has a valid factory" do
		FactoryGirl.create(:post).should be_valid
	end
	it "is invalid without a title" do
		FactoryGirl.build(:post, title: nil).should_not be_valid
	end
	it "is invalid without a latitude" do
		FactoryGirl.build(:post, latitude: nil).should_not be_valid
	end
	it "is invalid without a longitude" do
		FactoryGirl.build(:post, longitude: nil).should_not be_valid
	end
	it "is invalid without a description" do
		FactoryGirl.build(:post, description: nil).should_not be_valid
	end
	it "is invalid without a price" do
		FactoryGirl.build(:post, price: nil).should_not be_valid
	end
	it "is invalid without a security_deposit" do
		FactoryGirl.build(:post, security_deposit: nil).should_not be_valid
	end
end

