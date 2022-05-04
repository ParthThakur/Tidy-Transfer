Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'users#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end


  post 'short_link/:id', to: 'short_link#post'
  get 's/:url', to: 'short_link#show'

  delete 'transfers/:id', to: 'transfers#destroy'

  resources :transfers
  resources :users
end
