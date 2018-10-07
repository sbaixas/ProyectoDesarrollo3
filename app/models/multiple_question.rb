class MultipleQuestion < ApplicationRecord
  belongs_to :survey
  has_many :multiple_alternatives
  has_many :responses, :through => :multiple_alternatives, source: :multiple_responses
end
