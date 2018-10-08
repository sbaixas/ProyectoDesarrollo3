Rails.application.routes.draw do
  get 'interesting_categories/edit'
  devise_for :users, :controllers => { registrations: 'users/registrations', sessions:'users/sessions'}
  devise_scope :user do
    post "/users/confirmations", :to => "users/confirmations#activate",   :as => 'activate_user'
  end

  post "/interest_categories/edit", :to =>"interest_categories#update", as:'edit_interest_categories'
  get "/interest_categories/show", :to =>"interest_categories#show", as:'show_interest_categories'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
