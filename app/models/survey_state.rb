class SurveyState < ApplicationRecord
  require 'firebase_cloud_messenger'
  belongs_to :user
  belongs_to :survey

  after_create :deliver_notification

  def deliver_notification
    fcm = FirebaseCloudMessenger.new()
    fcm.notify_new_survey_one_user(self.user)
  end
end
