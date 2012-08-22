namespace :v1 do
  resources :videos, only: [:index, :show]
end
