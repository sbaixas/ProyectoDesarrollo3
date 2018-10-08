class AppCallsController < ApplicationController
	before_action :authenticate_token
  	skip_before_action :verify_authenticity_token
	
	def get_surveys
		@user = User.find(params[:id])
		respond_to do |format|
	      format.json{ render json: {"status" => "Success", "surveys" => @user.surveys}}
	    end
	end

end
