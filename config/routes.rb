Rails.application.routes.draw do
  get 'products/index'
  devise_for :users
  root to: "pages#home"
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
