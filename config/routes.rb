Rails.application.routes.draw do
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

  resources :public_habits, only: [:index]

  resources :public_rewards, only: [:index]

  resources :unlogged_habit_logs, only: [:index]

  get 'admin_login' => 'admin_sessions#new', :as => :admin_login
  post 'admin_login' => "admin_sessions#create"
  delete 'admin_logout' => 'admin_sessions#destroy', :as => :admin_logout

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :habits, only: [:index, :show, :destroy]
    resources :rewards
    resources :users, only: [:index, :show, :destroy]
  end
end
