class Review < ActiveRecord::Base
	  belongs_to :borrower, :class_name => 'User', required: true
	  belongs_to :lender, :class_name => 'User', required: true
	  belongs_to :exchange, :class_name => 'Post', required: true
	  

end
