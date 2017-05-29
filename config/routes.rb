Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'users/new'
  root 'pages#home'

  match '/signup', to:'users#new', via:'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
 # match '/profile', to: 'users#show', via:'get'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
