Rails.application.routes.draw do
  devise_for :users, path: 'users'

  get '/users/:id', to: 'users#show', as: 'user'

  resources :projects do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end

  root 'projects#index'
end
