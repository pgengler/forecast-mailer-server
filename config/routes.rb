Rails.application.routes.draw do
  # Health check endpoint used by Kamal Proxy.
  get "up" => "rails/health#show", as: :rails_health_check

  scope :api do
    jsonapi_resources :subscriptions
  end
end
