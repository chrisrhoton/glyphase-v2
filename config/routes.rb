Rails.application.routes.draw do

  root 'static_pages#home'

  resources :users

  get       '/signup'   => 'users#new'
  get       'login'     => 'sessions#new'
  post      'login'     => 'sessions#create'
  delete    'logout'    => 'sessions#destroy'

  get '/users/:id/feed' => 'users#feed', as: 'feed'
  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :glyphs, except: :index do
    resources :comments, only: [:create, :destroy]
  end

end
