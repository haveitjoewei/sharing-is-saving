# http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html
FactoryGirl.define do
	factory :user do |f|
	    email "sidwyn@gmail.com"
	    password "password"
	    password_confirmation "password"
	    date_of_birth Date.today
	    latitude 37.86449
	    longitude -122.254504
	    first_name "Sidwyn"
	    last_name "Koh"
	    created_at Date.today
	    updated_at Date.today
	    authentication_token "hxfRD4EykqGeZPsBiwKX"
	end

	factory :post do |f|
		f.title 'example title'
		f.latitude 123.45
		f.longitude 234.56
		f.description 'example description'
		f.price 12.34
		f.security_deposit 56.78
		f.status 1
	end
end