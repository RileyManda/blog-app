Rails.application.routes.draw do
  root 'users#index'

  # Define a route for user show page
  get '/users/:id', to: 'users#show', as: 'user'

  resources :users do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments
    end
  end
end
