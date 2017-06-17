Rails.application.routes.draw do
  resources :tests do 
      get 'download_pdf', to: 'tests#download_pdf'
  end


  resources :users
  resources :sessions, only: [:new, :create, :destroy]


  get 'users/new'
  root 'pages#home'


  match '/signup', to:'users#new', via:'get'
  # match '/download_pdf/:id',  to: 'tests#download_pdf',         via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
 # match '/profile', to: 'users#show,, via:'get'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
