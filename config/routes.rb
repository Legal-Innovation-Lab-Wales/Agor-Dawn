Rails.application.routes.draw do
  devise_for :users, path: 'users'

  put '/projects/:id/like', to: 'projects#like', as: 'like'
  delete '/projects/:id/unlike', to: 'projects#unlike', as: 'unlike'

  resources :projects do
    resources :comments
    resources :likes, only: %i[create destroy], controller: 'likes'
  end

  root 'projects#index'
end
