Rails.application.routes.draw do
  resources :bids, only: [:destroy]
  resources :sales
  root 'sales#index'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  
  post 'create_bid', to: 'bids#create', as: 'create_bid'
  get 'signup', to: 'users#new', as: 'signup'  
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
