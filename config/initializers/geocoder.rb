Geocoder.configure(
  lookup: :google,
  api_key: Rails.application.secrets.google_maps_api_key
)
