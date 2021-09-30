Rails.application.routes.draw do
  devise_for :users

  resources :users, only: :show
  resources :admin, only: :index do
    put '/users/:id', to: 'admin#toggle_admin', on: :collection, as: :toggle
    put 'approve', action: 'approve', on: :member, as: :approve
    put 'reject', action: 'reject', on: :member, as: :reject
  end

  resources :projects do
    resources :comments, only: %i[create destroy]
    resource :likes, only: %i[create destroy]
  end

  resources :flags, only: %i[index create] do
    put 'resolve', action: 'resolve', on: :member, as: :resolve
    put 'reject', action: 'reject', on: :member, as: :reject
  end

  root 'pages#home'
end
