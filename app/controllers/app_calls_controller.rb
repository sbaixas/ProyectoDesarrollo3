class AppCallsController < ApplicationController
	def get_surveys
		@user = ?
		respond_to do |format|
	      format.json{ render json: {"status" => "Success", "surveys" => @user.surveys}}
	    end
	end
end
