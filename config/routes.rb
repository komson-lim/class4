Rails.application.routes.draw do
  # resources :posts
  resources :users do
    resources :posts
  end
  get 'posts', to: 'posts#index'
  get 'posts/new', to: 'posts#post_new', as: 'new_post'
  post 'posts/new', to: 'posts#post_create', as: 'create_post'

  get 'create_fast', to: 'users#create_fast'
  get 'main' , to: 'users#main'
  post 'main', to: 'users#login'

  # get '/users/:id/posts/new', to: 'posts#new'
  # post '/users/:id/posts', to: 'posts#create'
  # get '/users/:id/posts/:post_id', to: 'posts#show'
  # get '/users/:id/posts/:post_id/edit', to: 'posts#edit'
  # patch 'users/:id/posts'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
