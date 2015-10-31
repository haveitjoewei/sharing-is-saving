class Exchange < ActiveRecord::Base
  belongs_to :borrower#, :class_name: 'User'#, foreign_key => 'borrower_id'
  belongs_to :lender#, :class_name: 'User'#, foreign_key => 'lender_id'
  belongs_to :post
end
