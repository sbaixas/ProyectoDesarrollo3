class Survey < ApplicationRecord
	has_many :survey_states
	has_many :survey_categories
  	has_many :users, :through => :survey_states, source: :user
  	has_many :categories, :through => :survey_categories, source: :category
  	has_many :open_questions
  	has_many :alternative_questions
  	has_many :multiple_questions
  	has_one :filter

  	def link_users
  		if self.available
	  		unless self.filter.blank?
	  			query = self.filter.query
	  		end
	  		if query.blank?
	  			sql = ("SELECT DISTINCT users.id FROM users LEFT OUTER JOIN user_groups ON (users.id = user_groups.user_id) LEFT OUTER JOIN groups ON (groups.id = user_groups.group_id) LEFT OUTER JOIN user_categories ON (users.id = user_categories.user_id) LEFT OUTER JOIN categories ON (categories.id = user_categories.category_id);")
	  		else
	  			sql = ("SELECT DISTINCT users.id FROM users LEFT OUTER JOIN user_groups ON (users.id = user_groups.user_id) LEFT OUTER JOIN groups ON (groups.id = user_groups.group_id) LEFT OUTER JOIN user_categories ON (users.id = user_categories.user_id) LEFT OUTER JOIN categories ON (categories.id = user_categories.category_id) WHERE " + query + " ;")
	  		end
	  		data_array = ActiveRecord::Base.connection.execute(sql).values.map{|row| {user_id:row[0], survey_id:self.id, state:'Not Delivered'}}
	  		data_array.each do |da|
	  			unless SurveyState.exists?(user_id:da[:user_id],survey_id:da[:survey_id])
	  				SurveyState.find_or_create_by(da)
	  			end
	  		end
  		end
  	end

  	def available
  		if DateTime.now > self.end_date or DateTime.now < self.start_date
  			return false
  		end
  		ans = SurveyState.find_by_id_and_state(self.id, "Answered")
  		if ans != nil
  			if ans.length >= self.max_answers 
  				return false
  			end
  		end
  		return true
  	end
end
