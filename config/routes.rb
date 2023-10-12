Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  root 'users#index'
  get '/users/:id', to: 'users#show', as: 'user'
  resources :posts
  resources :users do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :index, :create]
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
      post 'like', to: 'likes#create', on: :member
    end
    get 'posts/new', to: 'posts#new', as: 'new_post'
    get 'comment', to: 'posts#comment_form', on: :member


  end
   delete 'users/:user_id/posts/:id', to: 'posts#destroy', as: 'member'
end