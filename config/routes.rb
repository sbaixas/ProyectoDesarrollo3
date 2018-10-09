Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'
  get 'interesting_categories/edit'
  devise_for :users, :controllers => { registrations: 'users/registrations', sessions:'users/sessions'}
  devise_scope :user do
    post "/users/confirmations", :to => "users/confirmations#activate",   :as => 'activate_user'
  end
  get 'app_calls/get_surveys'
  get 'app_calls/get_profile_info'
  post 'app_calls/post_survey'
  post "/interest_categories/edit", :to =>"interest_categories#update", as:'edit_interest_categories'
  get "/interest_categories/", :to =>"interest_categories#show", as:'show_interest_categories'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
