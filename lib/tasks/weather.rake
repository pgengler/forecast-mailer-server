namespace :weather do
	namespace :forecastio do
		task configure: :environment do
			ForecastIO.configure do |config|
				config.api_key = Rails.application.secrets.forecastio_api_key
				config.default_params = { units: 'si' }
			end
		end
	end

	desc "Get forecasts"
	task get_forecasts: [ :environment, 'weather:forecastio:configure' ] do
		Subscription.all.each do |subscription|
			if subscription.geocoded?
				forecast = get_forecast(subscription)
				p forecast
			end
		end
	end

	private
	def get_forecast(subscription)
		ForecastIO.forecast(subscription.latitude, subscription.longitude)
	end
end
