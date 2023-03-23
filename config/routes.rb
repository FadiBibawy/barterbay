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
    resources :offers, only: [:new, :create, :show, :index] do
      resources :chatrooms, only: [:show] do
        # resources :messages, only: [:create]
      end
    end
  end

  resources :offers, only: [:show] do
    resources :messages, only: [:create]
    member do
      put :accept
      put :refuse
    end
  end
  resources :offers, only: [:destroy, :edit]
  resources :messages, only: [:destroy, :edit]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
