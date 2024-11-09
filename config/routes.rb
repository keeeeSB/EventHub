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
    end
  end
  resources :categories
end
