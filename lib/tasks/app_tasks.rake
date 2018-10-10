namespace :surveys do
  desc "a new task to be executed"
  task :link_users do
  	Survey.all.each do |sur|
  		sur.link_users
  	end
  end
end