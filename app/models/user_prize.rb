class UserPrize < ApplicationRecord
  belongs_to :user
  belongs_to :prize
end
