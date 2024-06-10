Rails.application.routes.draw do
  get 'admin_sessions/new'
  get 'admin_sessions/create'
  get 'admin_sessions/destroy'
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

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  get 'unlogged_habit_logs', to: 'unlogged_habit_logs#index', as: 'unlogged_habit_logs'
end
