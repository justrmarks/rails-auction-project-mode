Rails.application.routes.draw do
  # Home page should direct to the sales index page.
  root 'sales#index'

  # Routes for sessions.
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # Routes for users.
  resources :users, except: [:index] do
    collection do 
      get ':id/store', to: 'users#store', as: 'store'
    end
  end
  
  get 'signup', to: 'users#new', as: 'signup'  
  
  # Sale resource.
  resources :sales, except: [:destroy]
  
  #resources :bids, only: [:destroy]
  post 'create_bid', to: 'bids#create', as: 'create_bid'
end
