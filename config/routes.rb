Rails.application.routes.draw do
  root 'habits#index'

  resources :habits do
    resources :habit_logs, only: [:new, :create, :index, :update]
    collection do
      get 'unlogged', to: 'unlogged_habits#index'
    end
  end
  resources :users

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
end
