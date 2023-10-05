Rails.application.routes.draw do
  root 'users#index'
  get '/users/:id', to: 'users#show', as: 'user'

  resources :users do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments
      resources :likes, only: [:create]
      post 'like', to: 'likes#create', on: :member
    end
    get 'posts/new', to: 'posts#new', as: 'new_post'
  end
end