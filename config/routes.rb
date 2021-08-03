Rails.application.routes.draw do
  devise_for :users, path: 'users'

  resources :projects do
    resources :comments
  end

  root 'projects#index'
end
