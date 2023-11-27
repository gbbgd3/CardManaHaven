Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  get "/categories", to: 'categories#index'

  get "/search", to: "search#search_redirect", as: :search

  get "products/yugioh", to: "yugioh#index"
  get "products/yugioh/card/:id", to: 'yugioh#show', as: :yugioh_card
  get "products/yugioh/search(/:search)", to: 'yugioh#search', as: :yugioh_search
  
  get "products/magic-the-gathering", to: "mtg#index"
  get "products/magic-the-gathering/search(/:search)", to: "mtg#search", as: :magic_the_gathering_search

  get '/products', to: 'product#index'
  get '/products/product/:id', to: 'product#show', as: :products_show
  get '/products/search(/:search)', to: 'product#search', as: :products_search
end