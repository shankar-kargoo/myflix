Myflix::Application.routes.draw do
  
  root to: "pages#front"
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"
  get 'home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'
  get 'my_queue', to: 'queue_items#index'

  resources :videos, only: [:index, :show] do
    collection do 
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end

  post 'update_queue', to: "queue_items#update_queue"

  resources :categories, only: [:show]
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
end
