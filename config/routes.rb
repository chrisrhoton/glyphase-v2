Rails.application.routes.draw do

  root 'static_pages#home'

  get       '/about'    => 'static_pages#about', as: 'about'
  get       '/signup'   => 'users#new'
  get       'login'     => 'sessions#new'
  post      'login'     => 'sessions#create'
  delete    'logout'    => 'sessions#destroy'

  get '/users/:id/feed' => 'users#feed', as: 'feed'
  get '/nearby'         => 'glyphs#nearby', as: 'nearby', defaults: {format: :json}

  match "/panda/authorize_upload", :to => "panda#authorize_upload", via: :post

  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :glyphs, except: :index do
    resources :comments, only: [:create, :destroy]
  end
  resources :follow_relationships,       only: [:create, :destroy]

end
