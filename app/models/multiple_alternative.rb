class MultipleAlternative < ApplicationRecord
  belongs_to :multiple_question
  has_many :multiple_responses
end
