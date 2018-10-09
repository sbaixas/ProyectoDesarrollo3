class Category < ApplicationRecord
	has_many :user_categories
    has_many :survey_categories
    has_many :users, :through => :user_categories, source: :user
    has_many :surveys, :through => :survey_categories, source: :survey 
end
