class SurveyCategory < ApplicationRecord
  belongs_to :survey
  belongs_to :category
end
