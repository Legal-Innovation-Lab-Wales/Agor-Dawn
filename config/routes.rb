Rails.application.routes.draw do
  devise_for :users, path: 'users'

  put '/projects/:id/like', to: 'projects#like', as: 'like'
  delete '/projects/:id/unlike', to: 'projects#unlike', as: 'unlike'

  resources :projects do
    resources :comments
  end

  root 'projects#index'
end
