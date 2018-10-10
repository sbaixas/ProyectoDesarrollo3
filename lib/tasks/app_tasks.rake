namespace :surveys do
  desc "a new task to be executed"
  task :link_users => :environment do
  	Survey.all.each do |sur|
  		sur.link_users
  	end
  end
  task :refresh_time => :environment do
  	Survey.all.each do |sur|
  		if sur.available == false
  			SurveyState.find(survey:sur).each do |surst|
  				surst.update(state: 'Unavailable')
  			end
  		end
  	end
  	Prize.all.each do |pri|
  		pri.is_available
  	end
  end
end