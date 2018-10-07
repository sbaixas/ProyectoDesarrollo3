class OpenResponse < ApplicationRecord
  belongs_to :user
  belongs_to :open_question
end
