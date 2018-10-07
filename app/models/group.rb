class Group < ApplicationRecord
	has_many :user_groups
	has_many :group_categories
    has_many :users, :through => :user_groups, source: :user
    has_many :categories, :through => :group_categories, source: :category
end
