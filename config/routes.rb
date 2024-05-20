Rails.application.routes.draw do
  root :to => 'users#index'
  resources :users
  resources :habits

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
end
