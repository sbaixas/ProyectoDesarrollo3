class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :alternative_responses
  has_many :multiple_responses
  has_many :open_responses
  has_many :user_histories
  has_many :survey_states
  has_many :user_groups
  has_many :user_prizes
  has_many :user_categories
  has_many :surveys, :through => :survey_states, source: :survey
  has_many :groups, :through => :user_groups, source: :group
  has_many :prizes, :through => :user_prizes, source: :prize 
  has_many :categories, :through => :user_categories, source: :category 
  belongs_to :career

  before_create :set_access_token
  def self.random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  private
  def set_access_token
    self.auth_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless User.where(auth_token:token).exists?
    end
  end
end
