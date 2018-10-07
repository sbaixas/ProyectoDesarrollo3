class Alternative < ApplicationRecord
  belongs_to :alternative_question
  has_many :alternative_responses
end
