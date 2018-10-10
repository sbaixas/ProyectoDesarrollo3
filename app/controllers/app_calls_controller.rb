class AppCallsController < ApplicationController
	require 'date'
	before_action :authenticate_token
    skip_before_action :verify_authenticity_token

	def get_surveys
		respond_to do |format|
		  surveys = []
		  current_user.survey_states.each do |sur|
			  if(sur.state != "Answered" and sur.state != "Unavailable") 
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
			format.json{ 
				profiile_data = current_user.as_json
				profiile_data[:career] = current_user.career.name
				render json: {"status" => "Success", "profile_info" => profiile_data}
			}
		end
	end

	def update_profile_info

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



	def get_prizes
		respond_to do |format|


			format.json{ render json: {"status" => "Success","prizes" => Prize.where("available =true AND end_date>CURRENT_TIMESTAMP").collect{|p| Hash({price_id:p.id, name:p.name, description:p.description,end_date:p.end_date,is_available: p.available,selected:if p.users.include? @current_user then true else false end})}}}

		end
	end

	def add_prize
		respond_to do |format|
			format.json{ 
				prize = params[:id]
				available_prizes_ids = Prize.where(available:true).collect{|s| s.id}
				if Prize.find_by_id(prize).available?
					selected = UserPrize.where(user_id: @current_user.id,prize_id:available_prizes_ids)
					if !selected.empty?
						selected.delete_all
					end
					UserPrize.create(user_id: @current_user.id, prize_id: prize)
					puts "created"
					render json: {"status" => "Success"}
				else
					puts "else"
					render json: {"status" => "Prize Unavailable"}
				end
				
			}
		end
	end

	def post_survey
		respond_to do |format|
			format.json{
				open_responses=params[:open_responses]
				alternative_responses=params[:alternative_responses]
				multiple_responses=params[:multiple_responses] 
				survey = nil
				op_ok = true
				alt_ok = true
				mult_ok = true
				if open_responses.count + alternative_responses.count + multiple_responses.count == 3
					or_array = []
					open_responses.each do |ores|
						or_array.push(OpenResponse.new(user_id:current_user.id, open_question_id:ores["id"], answer:ores["content"]))
						if survey == nil
							survey = or_array[-1].open_question.survey
						else
							unless survey.id == or_array[-1].open_question.survey.id
								op_ok = false
							end
						end
					end
					ar_array = []
					alternative_responses.each do |ares|
						ar_array.push(AlternativeResponse.new(user_id:current_user.id, alternative_id:ares))
						if survey == nil
							survey = ar_array[-1].alternative.alternative_question.survey
						else
							unless survey.id == ar_array[-1].alternative.alternative_question.survey.id
								alt_ok = false
							end
						end
					end
					mr_array = []
					multiple_responses.each do|mres|
						mres.each do |res|
							mr_array.push(MultipleResponse.new(user_id:current_user.id, multiple_alternative_id:res))
							if survey == nil
								survey = mr_array[-1].multiple_alternative.multiple_question.survey
							else
								unless survey.id == mr_array[-1].multiple_alternative.multiple_question.survey.id
									mult_ok = false
								end
							end
						end
					end
					if op_ok and alt_ok and mult_ok
						current_user.update(accumulated_score: current_user.accumulated_score + survey.score)
						SurveyState.find_by(user_id: current_user.id, survey_id: survey.id).update(state: "Answered")
						or_array.each do |op_res|
							op_res.save
						end
						ar_array.each do |al_res|
							al_res.save
						end
						mr_array.each do |mu_res|
							mu_res.save
						end
						render json: {"status" => "Success"}
					else
						render json: {"status" => "Not all answers are from the same survey"}
					end
				else
					render json: {"status" => "Incorrect number of answers"}
				end
			}
		end
	end
end
