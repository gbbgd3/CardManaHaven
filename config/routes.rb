Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  get "/categories", to: 'categories#index'

  get "/yugioh_card/:id", to: 'yugioh#show', as: :yugioh_card
  get "/yugioh/search", to: 'yugioh#search'

  get "/magic-the-gathering/:id", to: 'mtg#show', as: :mtg_card

  get '/products', to: 'product#index'
  get '/products/:id', to: 'product#show', as: :products_show
  get '/prodcuts/search', to: 'product#search'
end
