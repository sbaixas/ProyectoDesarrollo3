class SurveyState < ApplicationRecord
  belongs_to :user
  belongs_to :survey
end
