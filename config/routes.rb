Rails.application.routes.draw do
  resources :pending_reservations
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { 
      registrations: 'users/registrations',
      sessions: 'users/sessions',
      confirmations: 'users/confirmations',
      passwords: 'users/passwords'
    }
  end
  
  namespace :api do
    namespace :v1 do
      resources :likes
      resources :reviews
      resources :reservations
      resources :jobs
      resources :contractors
      resources :users, only: [:index, :destroy, :update, :show]
    end
  end

  root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
