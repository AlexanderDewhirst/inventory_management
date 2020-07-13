Rails.application.routes.draw do
  resources :categories
  resources :features
  resources :items
  devise_for :users, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'register'
  }
  resources :users

  resource :pages, only: [:index]

  root to: "pages#index"
end
