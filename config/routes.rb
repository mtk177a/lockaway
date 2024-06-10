Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard/index'
  end
  root 'habits#index'

  resources :habits do
    resources :habit_logs, only: [:new, :create, :index, :update]
  end

  resources :rewards, only: [:index, :show] do
    collection do
      get 'user_rewards', to: 'rewards#user_rewards'
      get 'available_rewards', to: 'rewards#available_rewards'
    end
  end

  resources :users

  get 'admin_login' => 'admin_sessions#new', :as => :admin_login
  post 'admin_login' => "admin_sessions#create"
  delete 'admin_logout' => 'admin_sessions#destroy', :as => :admin_logout

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  get 'unlogged_habit_logs', to: 'unlogged_habit_logs#index', as: 'unlogged_habit_logs'
end
