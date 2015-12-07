# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


borrower = User.new
borrower.first_name = "Bob"
borrower.last_name = "Smith"
borrower.skip_confirmation!
borrower.email = "borrower@gmail.com"
borrower.password = "asdfasdf"
borrower.password_confirmation = "asdfasdf"
borrower.save!

lender = User.new
lender.skip_confirmation!
lender.first_name = "Sally"
lender.last_name = "Lee"
lender.email = "lender@gmail.com"
lender.password = "12345678"
lender.password_confirmation = "12345678"
lender.save!

pikachu = Post.new
pikachu.image_url = "https://s3-us-west-1.amazonaws.com/sharingissaving-private/uploads/019cb108-36e3-4b7b-a03d-3da32763c9f9/Pikachu.jpg"
pikachu.title = "Pikachu Sticker"
pikachu.description = "A sticker of Pikachu"
pikachu.security_deposit = 10
pikachu.price = 5
pikachu.street = "2525 Durant Ave"
pikachu.city = "Berkeley"
pikachu.state = "CA"
pikachu.status = 1
pikachu.category = 2
pikachu.user_id = lender.id
pikachu.save!

breast_pump = Post.new
breast_pump.image_url = "https://s3-us-west-1.amazonaws.com/sharingissaving-private/uploads/43a0952d-ab0f-48c8-9430-716cb1c7fd57/bp.jpg"
breast_pump.title = "Breast Pump"
breast_pump.description = "A brand new breast_pump"
breast_pump.security_deposit = 5
breast_pump.price = 1
breast_pump.street = "2525 Benvenue Ave"
breast_pump.city = "Berkeley"
breast_pump.state = "CA"
breast_pump.status = 1
breast_pump.category = 5
breast_pump.user_id = lender.id
breast_pump.save!

disney_boat = Post.new
disney_boat.image_url = "https://s3-us-west-1.amazonaws.com/sharingissaving-private/uploads/16f12e25-86c0-41ba-a48f-e44d77ea0c07/10835441_10153248399827269_5185658460523873308_o.jpg"
disney_boat.title = "Disney Boat"
disney_boat.description = "A retired boat used in Disneyland"
disney_boat.security_deposit = 5000
disney_boat.price = 100
disney_boat.street = "2150 Shattuck Ave"
disney_boat.city = "Berkeley"
disney_boat.state = "CA"
disney_boat.status = 1
disney_boat.category = 7
disney_boat.user_id = lender.id
disney_boat.save!

exchange = Exchange.new
exchange.lender_id = 2
exchange.borrower_id = 1
exchange.post_id = 1
exchange.status = 4
exchange.save!

review = Review.new
review.lender_id = 2
review.reviewer = borrower
review.exchange_id = 1
review.rating = 5
review.content = "This was awesome! I really liked it."
review.save!


