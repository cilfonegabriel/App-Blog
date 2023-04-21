Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :new, :destroy] do
      resources :likes, only: [:new, :create]
      resources :comments, only: [:new, :create, :destroy]
    end
  end
  
  namespace :api do
    resources :users do
      resources :posts do
        resources :comments
      end
    end
  end
end