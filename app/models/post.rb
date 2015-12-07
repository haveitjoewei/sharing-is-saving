class Post < ActiveRecord::Base
	paginates_per 9
  	belongs_to :user
  	has_many :exchanges
  	has_many :reviews
  	
	geocoded_by :address
  	before_validation :geocode
  	def address
  		[street, city, state].compact.join(', ')
	end
	validates :street, presence: true
	validates :city, presence: true
	validates :state, presence: true

	validates :title, presence: true, length: {maximum: 64}
	validates :latitude, presence: true, numericality: true, :inclusion => {:in => -180..180}
	validates :longitude, presence: true, numericality: true, :inclusion => {:in => -180..180}
	validates :description, presence: true, length: {maximum: 4098}
	validates :price, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}
	validates :security_deposit, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}
	validates :status, presence: true, numericality: true, :inclusion => {:in => 1..4, :message => "must be an integer between 1 and 4"}
	validates :category, presence: true, numericality: true, :inclusion => {:in => 1..13, :message => "must be an integer between 1 and 13"}

	def self.search(query)
	  # where(:title, query) -> This would return an exact match of the query
		if query
			where("title ILIKE ? or description ILIKE ?", "%#{query}%", "%#{query}%") 
		else
			self.all
		end
	end
end
