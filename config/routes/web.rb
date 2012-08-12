resource :session, only: [:new, :create, :destroy]
resources :users, only: [:new, :create]
resources :videos, only: [:index, :show]

get 'facebook', to: 'facebook#index', as: 'facebook'
get 'facebook/callback' => 'facebook#callback'

root to: 'home#index'

require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
