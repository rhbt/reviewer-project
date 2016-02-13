Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'signup'  => 'users#new'
  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  resources :users, only: [:new, :create, :index]

end
