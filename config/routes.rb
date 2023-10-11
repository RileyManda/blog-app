Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  get '/users/:id', to: 'users#show', as: 'user'
  resources :posts
  resources :users do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
      post 'like', to: 'likes#create', on: :member
    end
    get 'posts/new', to: 'posts#new', as: 'new_post'
    get 'comment', to: 'posts#comment_form', on: :member
  end
end