Myflix::Application.routes.draw do
  get 'home(/:action)', controller: 'videos'
  get 'ui(/:action)', controller: 'ui'
  resources :videos
  resources :categories
end
