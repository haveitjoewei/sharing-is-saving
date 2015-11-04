class Review < ActiveRecord::Base
	  belongs_to :reviewer, :class_name => 'User', required: true
	  belongs_to :lender, :class_name => 'User', required: true
	  belongs_to :exchange, :class_name => 'Exchange', required: true
	  
	  #requirements for reviews
	validates :review, presence: true#, length: {maximum: 4098}
	validates :rating, presence: true, numericality: true, :inclusion => {:in => 1..5, :message => "must be an integer between 1 and 5"}
end
