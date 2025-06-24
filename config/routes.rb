# config/routes.rb
Rails.application.routes.draw do
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Main application routes
  resources :movies, only: [ :index ] do
    collection do
      get :search # Optional: For explicit search route if needed
    end
  end

  # Root route
  root "movies#index"

  # For any other routes you might add in the future
  # Example: get 'movies/by_actor', to: 'movies#by_actor'
end
