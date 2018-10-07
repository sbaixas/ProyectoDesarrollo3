class AlternativeQuestion < ApplicationRecord
  belongs_to :survey
  has_many :alternatives
  has_many :responses, :through => :multiple_alternatives, source: :alternative_responses
end
