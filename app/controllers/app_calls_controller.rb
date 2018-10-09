class AppCallsController < ApplicationController
	
	before_action :authenticate_token
    skip_before_action :verify_authenticity_token

	def get_surveys
		respond_to do |format|
		  surveys = []
		  current_user.surveys.each do |sur|
		  	survey = sur.as_json
		  	survey["OpenQuestions"] = []
		  	survey["AlternativeQuestions"] = []
		  	survey["MultipleQuestions"] = []
		  	sur.open_questions.each do |oq|
		  		survey["OpenQuestions"].push(oq.as_json)
		  	end
		  	sur.alternative_questions.each do |aq|
		  		alternative_questions = aq.as_json
		  		alternative_questions["Alternatives"] = []
		  		aq.alternatives.each do |a|
			  		alternative_questions["Alternatives"].push(a.as_json)
		  		end
		  		survey["AlternativeQuestions"].push(alternative_questions)
		  	end
		  	sur.multiple_questions.each do |mq|
		  		multiple_questions = mq.as_json
		  		multiple_questions["MultipleAlternatives"] = []
		  		mq.multiple_alternatives.each do |ma|
		  			multiple_questions["MultipleAlternatives"].push(ma.as_json)
		  		end
		  		survey["MultipleQuestions"].push(multiple_questions)
		  	end
		  	surveys.push(survey)
		  end
	      format.json{ render json: {"status" => "Success", "surveys" => surveys}}
	    end
	end

end
