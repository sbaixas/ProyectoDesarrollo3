class FirebaseCloudMessenger
  require 'fcm'


  def initialize
    @fcm = FCM.new("AAAAZU_QpRQ:APA91bESpYzjRXMhvPSZ1eXKiKhviFdoKKBEJsTZpyIOmAy8ejoEE7AcoLO0VyrtqhAQhDA448s_oLOqtmGMw_op6zJuUNAmfAUA6gaeczBU98OMWvcUvIRkEFFdYY-A01mf4i7Gu3IR")
  end


  #this receive an Active Record Relation of Users
  def notify_new_survey(users)
    registration_ids=  users.where(firebase_token: !nil?).collect{|u| u.firebase_token}# an array of one or more client registration tokens
    options = {data: {subject:"Survey", message: "Hay nuevas encuestas disponibles"}, collapse_key: "updated_score"}
    response = @fcm.send(registration_ids, options)
  end

  def notify_new_survey_one_user(user)
    registration_ids= [user.firebase_token]
    options = {data: {subject:"Survey", message: "Hay nuevas encuestas disponibles"}, collapse_key: "updated_score"}
    response = @fcm.send(registration_ids, options)
  end
  #send notification to all users in the platform
  def notify_new_raffle()
    registration_ids=  User.where.not(firebase_token: !nil).collect{|u| u.firebase_token}# an array of one or more client registration tokens
    puts registration_ids
    options = {data: {subject:"Raffle", message: "Hay nuevos sorteos disponibles"}, collapse_key: "updated_score"}
    response = @fcm.send(registration_ids, options)
  end


end