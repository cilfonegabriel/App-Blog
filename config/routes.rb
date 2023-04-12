Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
    resources :posts, only: [:index, :show, :create, :new] do
      resources :likes, only: [:new, :create]
      resources :comments, only: [:new, :create]
    end
  end
end