Rails.application.routes.draw do
  root 'users#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts, only: [:index, :show] do
    resources :users, only: [:index, :show]
end
end
