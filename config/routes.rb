Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'help'    => 'static_pages#help'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :reviews, only: [:index, :new, :create, :destroy, :show]

end
