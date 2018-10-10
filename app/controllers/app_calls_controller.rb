class AppCallsController < ApplicationController
	require 'date'
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
			  	sur.survey.open_questions.each do |oq|
			  		survey["OpenQuestions"].push(oq.as_json)
			  	end
			  	sur.survey.alternative_questions.each do |aq|
			  		alternative_questions = aq.as_json
			  		alternative_questions["Alternatives"] = []
			  		aq.alternatives.each do |a|
				  		alternative_questions["Alternatives"].push(a.as_json)
			  		end
			  		survey["AlternativeQuestions"].push(alternative_questions)
			  	end
			  	sur.survey.multiple_questions.each do |mq|
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
			profiile_data = current_user.as_json
			profiile_data["career"] = current_user.career.name
			format.json{ render json: {"status" => "Success", "profile_info" => profiile_data}}
		end
	end

	def update_profile_info
		sleep(4)
		user_info = params[:user].permit(:first_name,:last_name,:gender,:birthdate,:rut)
		if current_user.update(user_info)
			render json:{status:200},status: :ok
		else
			render json:{status:202,message:"parametros invalidos"}, status: :accepted

		end

	end
	def get_careers
		respond_to do |format|
			format.json{ render json: {"status" => "Success", "careers" => Career.all}}
		end
	end

	def update_prize_postulation
		prize_id = params[:prize_id]
		prize = Prize.find_by(id:prize_id)
		if prize.nil?
			render json:{message:"Sorteo Inexistente",status:202},status:202
			return
		end
		open_prize_ids = Prize.where("end_date> CURRENT_TIMESTAMP").collect{|p| p.id}
		current_time = DateTime.now.to_time.utc
		puts current_time.utc
		puts prize.end_date.utc
		if prize.end_date.utc>current_time.utc
			#is available
			print open_prize_ids
			UserPrize.where(prize_id:open_prize_ids,user:@current_user).delete_all
			UserPrize.create(user:@current_user,prize:prize)
			render json:{message:"Sorteo Inexistente",status:200},status:200
			return
		else
			render json:{message:"Sorteo Cerrado",status:202},status:202
			return
	#		render :json=>{message:"Encuesta cerrada",status:202}
		end
	end

	def get_prizes
		respond_to do |format|
			format.json{ render json: {"status" => "Success",
																 "prizes" => Prize.where('end_date>CURRENT_TIMESTAMP').collect{|p|.}

			}}
		end
	end

	def add_prize
		prize = JSON.parse params['id']
		amount = JSON.parse params['amount']
		if amount <= current_user.accumulated_score
			if Prize.find_by_id(prize).available
				if UserPrize.exists?(user_id: current_user.id, prize_id: prize)
					user_prize = UserPrize.find_by(user_id: current_user.id, prize_id: prize.id)
					user_prize.update(amount: user_prize.amount + amount)
				else
					UserPrize.create(user_id: current_user.id, prize_id: prize, amount: amount)
				end
				current_user.update(accumulated_score: current_user.accumulated_score - amount)
			end
			respond_to do |format|
				format.json{ render json: {"status" => "Success"}}
			end
		else
			respond_to do |format|
				format.json{ render json: {"status" => "Not enough score"}}
			end
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
		current_user.update(accumulated_score: current_user.accumulated_score + survey.score)
		SurveyState.find_by(user_id: current_user.id, survey_id: survey.id).update(state: "Answered")


		respond_to do |format|
			format.json{ render json: {"status" => "Success"}}
		end
	end
end
