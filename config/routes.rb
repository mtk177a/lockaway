Rails.application.routes.draw do
  root 'home#index'

  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  resources :habits do
    resources :habit_logs, only: [:new, :create, :index, :update]
  end

  resources :public_habits, only: [:index, :show]

  resources :public_rewards, only: [:index]

  resources :rewards, only: [:index, :show] do
    collection do
      get 'available_rewards'
    end
  end

  resources :unlogged_habit_logs, only: [:index]

  resources :user_rewards, only: [:index, :show]

  resources :users

  namespace :admin do
    get 'login', to: 'user_sessions#new', as: :login
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy', as: :logout

    get 'dashboard', to: 'dashboard#index'
    resources :habits, only: [:index, :show, :destroy]
    resources :rewards
    resources :users, only: [:index, :show, :destroy]
  end
end
