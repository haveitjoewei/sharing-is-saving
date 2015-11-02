class Exchange < ActiveRecord::Base
  belongs_to :borrower, :class_name => 'User', required: true
  belongs_to :lender, :class_name => 'User', required: true
  belongs_to :post, :class_name => 'Post', required: true

  validates :status, presence: true, numericality: true, :inclusion => {:in => 1..5, :message => "must be an integer between 1 and 5"}
end