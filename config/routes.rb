Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  root 'sessions#new'
end
