Rails.application.routes.draw do
  root "projects#index"

  get 'projects/index', to: "projects#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  devise_for :users

end
