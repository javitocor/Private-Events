Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  post '/attend', to: 'events#attend'

  resources :events, only: [:index, :new, :create, :show]
  
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  root 'sessions#new'
end
