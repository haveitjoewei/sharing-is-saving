class Post < ActiveRecord::Base
  	belongs_to :user
  	has_many :exchange
	validates :title, presence: true, length: {maximum: 64}
	validates :latitude, presence: true, numericality: true, :inclusion => {:in => -180..180}
	validates :longitude, presence: true, numericality: true, :inclusion => {:in => -180..180}
	validates :description, presence: true, length: {maximum: 4098}
	validates :price, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}
	validates :security_deposit, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}
	validates :status, presence: true, numericality: true, :inclusion => {:in => 0..3, :message => "must be an integer between 0 and 3"}
end
