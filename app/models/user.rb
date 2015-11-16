class User < ActiveRecord::Base
  acts_as_token_authenticatable
  
  validates :first_name, presence: true, length: {minimum: 1, maximum: 50}
  validates :last_name, presence: true, length: {minimum: 1, maximum: 50}


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  # for posts
  has_many :posts
  has_many :exchanges
  has_many :reviews
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  before_create :set_foo_to_now
  
  def set_foo_to_now
    self.date_of_birth = Time.now # TODO: Sidwyn, add date of birth
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.extra.raw_info.first_name   # assuming the user model has a name
      user.last_name = auth.extra.raw_info.last_name   # assuming the user model has a name
      if auth.extra.raw_info.birthday
        user.date_of_birth = auth.extra.raw_info.birthday
      else
        user.date_of_birth = Time.now
      end
    end
  end

end
