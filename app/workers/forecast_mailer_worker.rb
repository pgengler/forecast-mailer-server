class ForecastMailerWorker
	include Sidekiq::Worker

	def perform(subscription_id)
		subscription = Subscription.find(subscription_id)
		forecast = get_forecast(subscription)
		Time.zone = subscription.timezone
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
		ForecastIO.api_key = Rails.application.secrets.forecastio_api_key
		ForecastIO.forecast(subscription.latitude, subscription.longitude, params: { units: 'si' })
	end
end
