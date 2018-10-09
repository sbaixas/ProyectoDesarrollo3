class Survey < ApplicationRecord
	has_many :survey_states
	has_many :survey_categories
  	has_many :users, :through => :survey_states, source: :user
  	has_many :categories, :through => :survey_categories, source: :category
  	has_many :open_questions
  	has_many :alternative_questions
  	has_many :multiple_questions
  	has_one :filter
end
