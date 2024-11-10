Rails.application.routes.draw do
  root "events#index"
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    resources :events do
      resources :favorites, only: [:create, :destroy]
      resources :joins,     only: [:create, :destroy]
      resources :reviews,   only: [:create, :destroy]
    end
    resources :favorites, only: [:index]
    resources :joins,     only: [:index]
  end
  resources :categories, only: [:create]
end
