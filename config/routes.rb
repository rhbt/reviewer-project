Rails.application.routes.draw do
  
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'
  get "about" => "static_pages#about"
  get "help"    => "static_pages#help"
  get "contact" => "static_pages#contact"
  
  get "signup"  => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout"  => "sessions#destroy"
  
  
  resources :users
  resources :reviews, only: [:index, :new, :create, :destroy, :show]
  resources :stickied_reviews, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

end
