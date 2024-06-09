Rails.application.routes.draw do
  get 'rewards/index'
  get 'rewards/show'
  root 'habits#index'

  resources :habits do
    resources :habit_logs, only: [:new, :create, :index, :update]
  end

  resources :users

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  get 'unlogged_habit_logs', to: 'unlogged_habit_logs#index', as: 'unlogged_habit_logs'
end
