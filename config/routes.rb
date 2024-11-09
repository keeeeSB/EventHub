Rails.application.routes.draw do
  get 'events/index'
  get 'events/new'
  get 'events/show'
  get 'events/edit'
  root "users#new"
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :categories
end
