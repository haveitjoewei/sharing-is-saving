class User < ActiveRecord::Base
  acts_as_token_authenticatable
  
  validates :first_name, presence: true, length: {minimum: 1, maximum: 50}
  validates :last_name, presence: true, length: {minimum: 1, maximum: 50}


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  # for posts
  has_many :post
  has_many :exchange
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :set_foo_to_now
  
  def set_foo_to_now
    self.date_of_birth = Time.now # TODO: Sidwyn, add date of birth
  end
  
  def send_on_create_confirmation_instructions
    # Removing confirmation
    # byebug 
  end

end
