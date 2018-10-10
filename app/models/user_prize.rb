class UserPrize < ApplicationRecord
  belongs_to :user
  belongs_to :prize
  before_save

  def update_prize


  end
end
