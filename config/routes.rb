Rails.application.routes.draw do
  devise_for :users, path: 'users'

  resources :users, only: :show
  resources :admin, only: :index do
    put '/users/:id', to: 'admin#toggle_admin', on: :collection, as: :toggle
  end

  resources :projects do
    resources :comments, only: :create
    resources :likes, only: %i[create destroy]
  end

  root 'pages#home'
end
