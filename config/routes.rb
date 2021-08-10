Rails.application.routes.draw do
  devise_for :users, path: 'users'

  resources :projects do
    resources :comments, only: %i[:create], controller: 'comments'
  end

  resources :images, only: [:create]

  root 'projects#index'
end
