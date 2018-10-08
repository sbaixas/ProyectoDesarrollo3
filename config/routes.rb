Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations', sessions:'users/sessions'}
  devise_scope :user do
    post "/users/confirmations", :to => "users/confirmations#activate",   :as => 'activate_user'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
