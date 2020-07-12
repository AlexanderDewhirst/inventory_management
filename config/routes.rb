Rails.application.routes.draw do
  resources :attributes
  resources :items
  devise_for :users, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'register'
  }
  resources :users

  resource :pages, path: '' do
    get :index
  end

  root to: "pages#index"
end
