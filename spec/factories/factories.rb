# http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html
FactoryGirl.define do
	sequence :email do |n|
		"email#{n}@example.com"
	end

	factory :user do |f|
	    email
	    f.password "password"
	    f.password_confirmation "password"
	    f.date_of_birth Date.today
	    f.latitude 37.86449
	    f.longitude -122.254504
	    f.first_name "Sidwyn"
	    f.last_name "Koh"
	    f.created_at Date.today
	    f.updated_at Date.today
	    f.authentication_token "hxfRD4EykqGeZPsBiwKX"
	end

	factory :user2, class: User do |f|
	    email
	    f.password "password"
	    f.password_confirmation "password"
	    f.date_of_birth Date.today
	    f.latitude 37.86449
	    f.longitude -122.254504
	    f.first_name "Sidwyn"
	    f.last_name "Koh"
	    f.created_at Date.today
	    f.updated_at Date.today
	    f.authentication_token "hxfRD4EykqGeZPsBiwKY"
	end

	factory :user3, class: User do |f|
	    email
	    f.password "password"
	    f.password_confirmation "password"
	    f.date_of_birth Date.today
	    f.latitude 37.86449
	    f.longitude -122.254504
	    f.first_name "Sidwyn"
	    f.last_name "Koh3"
	    f.created_at Date.today
	    f.updated_at Date.today
	    f.authentication_token "hxfRD4EykqGeZPsBiwKY"
	end

	factory :post do |f|
		f.title 'example title'
		f.description 'example description'
		f.price 12.34
		f.security_deposit 56.78
		f.status 1
		f.association :user, factory: :user
		f.street '2525 Benvenue Ave'
		f.city 'Berkeley'
		f.state 'CA'
		f.category 1
	    created_at Date.today
	    updated_at Date.today
	end

	factory :exchange do |f|
		f.association :lender, factory: :user
		f.association :borrower, factory: :user2
		f.association :post, factory: :post
		f.status 1
	    f.created_at Date.today
	    f.updated_at Date.today
	end

	factory :review do |f|
		f.association :reviewer, factory: :user2
		f.association :lender, factory: :user
		f.association :exchange, factory: :exchange
		f.rating 1
		f.content 'Joseph is my sucky sucky'
	    f.created_at Date.today
	    f.updated_at Date.today
	end

	factory :activity, class: 'PublicActivity::Activity' do
	   trackable_id :answer
	   recipient_id :user
	   owner_id :user
	end
	
end