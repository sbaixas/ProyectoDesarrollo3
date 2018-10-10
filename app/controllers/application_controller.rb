class ApplicationController < ActionController::Base
	 before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :age, :gender, :rut, :career])
    devise_parameter_sanitizer.permit(:account_update , keys: [:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :age, :gender, :rut, :career])

  end

   private
   def authenticate_token
     authenticate_or_request_with_http_token do |token,options|
       @current_user=User.find_by(auth_token:token)
       current_user=@current_user
     end
   end
end

