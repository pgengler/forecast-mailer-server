class ForecastMailerWorker
	include Sidekiq::Worker

	def perform(subscription_id)
		subscription = Subscription.find(subscription_id)
		forecast = get_forecast(subscription)
		Time.zone = forecast.timezone
		WeatherForecastMailer.daily(subscription, forecast).deliver
	end

	def self.send_forecast_emails
		Subscription.active.each do |subscription|
			if subscription.geocoded?
				perform_async(subscription.id)
			end
		end
	end

	private

	def get_forecast(subscription)
		api_key = Rails.application.secrets.openweathermap_api_key
		units = subscription.units == 'en' ? 'imperial' : 'metric'
		api = OpenWeatherMap::API.new(api_key)
		api.forecast(subscription.latitude, subscription.longitude, units)
	end
end
