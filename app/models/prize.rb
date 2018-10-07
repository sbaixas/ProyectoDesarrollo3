class Prize < ApplicationRecord
  	has_many :user_prizes
  	has_many :users, :through => :user_prizes, source: :user 
end
