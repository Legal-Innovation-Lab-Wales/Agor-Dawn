Rails.application.routes.draw do
  root "projects#index"

  put '/projects/:id/like', to: 'projects#like', as: 'like'

  get 'projects/index', to: "projects#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  devise_for :users

  resources :projects



end
