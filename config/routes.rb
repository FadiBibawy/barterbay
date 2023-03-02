Rails.application.routes.draw do
  get 'users/show'
  # get 'reviews/new'
  # get 'products/index'
  devise_for :users

  devise_scope :user do
    resources :users, only: [:show] do
      resources :reviews, only: [:new, :create]
    end
  end

  root to: "pages#home"
  resources :products do
    resources :offers
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
