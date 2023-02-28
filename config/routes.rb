Rails.application.routes.draw do
  # get 'products/index'
  devise_for :users

  devise_scope :user do
    resources :users, only: [] do
      resources :reviews, only: [:new]
    end
  end

  root to: "pages#home"
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
