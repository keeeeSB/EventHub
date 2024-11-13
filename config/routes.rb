Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "events#upcoming"
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    resources :events do
      collection do
        get "upcoming"
        get "past"
      end
      resources :favorites, only: [:create, :destroy]
      resources :joins,     only: [:create, :destroy]
      resources :reviews,   only: [:create, :edit, :update, :destroy]
    end
    resources :favorites, only: [:index]
    resources :joins,     only: [:index]
  end
  resources :categories, only: [:create, :show]
end
