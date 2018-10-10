class Prize < ApplicationRecord
  	has_many :user_prizes
  	has_many :users, :through => :user_prizes, source: :user
		belongs_to :user
		after_save :process_winner

  	def is_available
  		if DateTime.now > self.end_date or DateTime.now < self.start_date
  			self.update(available: false)
  			return false
  		else
  			self.update(available: true)
  			return true
  		end
		end

	def process_winner
		if !self.user.nil?
			UserMailer.with(user:self.user,prize:self).winner_mail.deliver_now
		end
	end
end
