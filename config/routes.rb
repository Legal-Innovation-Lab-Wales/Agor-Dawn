Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    resources :users, only: :show
    resources :admin, only: :index do
      put '/users/:id', to: 'admin#toggle_admin', on: :collection, as: :toggle
      put 'approve', action: 'approve', on: :member, as: :approve
      put 'reject', action: 'reject', on: :member, as: :reject
    end

    resources :projects do
      resources :comments, only: :create
      resource :likes, only: %i[create destroy]
    end

    root 'pages#home', as: :authenticated_root
  end

  unauthenticated do
    root to: redirect('/users/sign_in')
  end
end
