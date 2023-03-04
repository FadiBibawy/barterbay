Rails.application.routes.draw do
  # get 'reviews/new'
  # get 'products/index'
  root to: "pages#home"

  devise_for :users
  get 'users/show'

  devise_scope :user do
    resources :users, only: [:show] do
      resources :reviews, only: [:new, :create]
    end
  end

  resources :products do
    resources :offers, only: [:new, :create, :show] do
      resources :chatrooms, only: [:show]
    end
  end

  resources :offers, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
