class Prize < ApplicationRecord
  	has_many :user_prizes
  	has_many :users, :through => :user_prizes, source: :user
  	belongs_to :user


  	def is_available
  		if DateTime.now > self.end_date or DateTime.now < self.start_date
  			if DateTime.now > self.end_date and self.user == nil
  				self.set_winner
  			end
  			self.update(available: false)
  			return false
  		else
  			self.update(available: true)
  			return true
  		end

		end



  	def set_winner
  		users_array = []
  		count = 0
  		self.user_prizes.each do |up|
  			users_array.push([count, up.user.accumulated_score,up.user])
  			count = count+1+up.user.accumulated_score
  		end
  		winner = nil
  		winning_number = rand(0..count-1)
  		users_array.each do |ua|
  			if winning_number >= ua[0] and winning_number <= ua[1]
  				winner = ua[2]
  			end
  		end
  		if winner != nil
  			self.user = winner
  			self.user.update(accumulated_score: 0)
  			self.save
				UserMailer.with(user:self.user,prize:self).winner_mail.deliver_now
  		end
  	end
end
