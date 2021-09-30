Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    resources :users, only: :show
    resources :admin, only: :index

    scope 'admin/users/:id', controller: 'admin' do
      put '/make_admin', action: 'make_admin', as: :make_admin
      put '/approve', action: 'approve', as: :approve
      put '/reject', action: 'reject', as: :reject
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
