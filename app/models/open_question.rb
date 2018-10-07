class OpenQuestion < ApplicationRecord
  belongs_to :survey
  has_many :open_responses
end
