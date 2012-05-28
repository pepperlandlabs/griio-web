GriioWeb::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  get 'facebook', to: 'facebook#index', as: 'facebook'
  get 'facebook/callback' => 'facebook#callback'

  root to: 'home#index'
end
