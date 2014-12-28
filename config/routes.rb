Rails.application.routes.draw do

  root 'static_pages#home'

  resources :users

  match '/signup', to: 'users#new', via: 'get'
  
end
