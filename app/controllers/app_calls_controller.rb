class AppCallsController < ApplicationController
	
	before_action :authenticate_token
    skip_before_action :verify_authenticity_token

	def get_surveys
		respond_to do |format|
		  surveys = []
		  current_user.survey_states.each do |sur|
			  if(sur.state != "Answered") 
			  	survey = sur.survey.as_json
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
			  	sur.update(state: 'Delivered')
			  end
		  end
	      format.json{ render json: {"status" => "Success", "surveys" => surveys}}
	    end
	end

	def get_profile_info
		respond_to do |format|
			format.json{ render json: {"status" => "Success", "profile_info" => current_user}}
		end
	end

	def post_survey
		open_responses = JSON.parse params['open_responses']
		alternative_responses = JSON.parse params['alternative_responses']
		multiple_responses = JSON.parse params['multiple_responses']

		survey = nil
		open_responses.each do |ores|
			res = OpenResponse.create(user_id:current_user.id, open_question_id:ores["id"], answer:ores["content"])
			survey = res.open_question.survey
		end

		alternative_responses.each do |ares|
			res = AlternativeResponse.create(user_id:current_user.id, alternative_id:ares)
			survey = res.alternative.alternative_question.survey
		end

		multiple_responses.each do|mres|
			mres.each do |res|
				res = MultipleResponse.create(user_id:current_user.id, multiple_alternative_id:res)
				survey = res.multiple_alternative.multiple_question.survey
			end
		end

		SurveyState.find_by(user_id: current_user.id, survey_id: survey.id).update(state: "Answered")


		respond_to do |format|
			format.json{ render json: {"status" => "Success"}}
		end
	end
end
