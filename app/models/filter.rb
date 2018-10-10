class Filter < ApplicationRecord
  belongs_to :survey
  after_create :call_survey_link_users
  after_update :call_survey_link_users
  def call_survey_link_users
  	self.survey.link_users
  end
end
