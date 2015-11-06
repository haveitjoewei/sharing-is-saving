class AddNullConstraint < ActiveRecord::Migration
  def change
  	change_column_null :exchanges, :lender_id, false
  	change_column_null :exchanges, :borrower_id, false
  	change_column_null :exchanges, :post_id, false
  	change_column_null :exchanges, :status, false

  	change_column_null :posts, :title, false
  	change_column_null :posts, :latitude, false
  	change_column_null :posts, :longitude, false
  	change_column_null :posts, :description, false
  	change_column_null :posts, :price, false
  	change_column_null :posts, :security_deposit, false
  	change_column_null :posts, :status, false
  	change_column_null :posts, :user_id, false
  	change_column_null :posts, :category, false
  	change_column_null :posts, :street, false
  	change_column_null :posts, :city, false
  	change_column_null :posts, :state, false

  	change_column_null :reviews, :reviewer_id, false
  	change_column_null :reviews, :lender_id, false
  	change_column_null :reviews, :exchange_id, false
  	change_column_null :reviews, :rating, false
  	change_column_null :reviews, :content, false
  end
end
