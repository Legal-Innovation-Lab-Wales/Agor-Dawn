Rails.application.routes.draw do
  devise_for :users, path: 'users'

  # authenticated :user do
    resources :projects do
      resources :comments, only: %i[create]
    end
  # end

  # resources :projects, only: %i[index show]

  root 'projects#index'
end
