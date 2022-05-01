Rails.application.routes.draw do
  resources :transfers
  get 'users' => 'users#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  post 'short_link/:id', to: 'short_link#post'
  get 's/:url', to: 'short_link#show'

  delete 'transfers/:id', to: 'transfers#destroy'

  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  root 'sessions#new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
