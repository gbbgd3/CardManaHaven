require 'rack/cors'

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins 'http://localhost:3000'
        resource '*', headers: :any, credentials: true, methods: [:get, :post, :patch, :put]
    end
end
  