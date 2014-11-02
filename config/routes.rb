Myflix::Application.routes.draw do
  get 'home(/:action)', controller: 'videos'
  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:index, :show] do
    collection do 
      post :search, to: "videos#search"
    end
  end

  resources :categories, only: [:show]

end
