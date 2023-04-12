Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :posts do
      resources :comments
  end

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
end
