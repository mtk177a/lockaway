Rails.application.routes.draw do
  get 'habit_logs/new'
  get 'habit_logs/create'
  root :to => 'users#index'
  resources :users
  resources :habits

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
end
