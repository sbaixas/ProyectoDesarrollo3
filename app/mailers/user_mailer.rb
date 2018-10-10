class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def activation_email
    @user = params[:user]
    @password = params[:password]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Activation Successfully')

  end

  def winner_mail
    @user = params[:user]
    @prize = params[:prize]
    mail(to: @user.email, subject: 'Prize Winner!')
  end
end
