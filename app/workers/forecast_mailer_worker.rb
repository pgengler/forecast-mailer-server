class ForecastMailerWorker < ApplicationJob
	def perform(subscription_id)
		subscription = Subscription.find(subscription_id)
		forecast = get_forecast(subscription)
		Time.zone = forecast.timezone
		WeatherForecastMailer.daily(subscription, forecast).deliver_now
	end

	def self.send_forecast_emails
		Subscription.active.each do |subscription|
			next unless subscription.geocoded? && subscription.timezone.present?
			local_now = Time.now.in_time_zone(subscription.timezone)
			next unless local_now.hour == 6
			today = local_now.to_date
			# Atomically claim this subscription for today so concurrent polls
			# (or overlapping recurring runs) can't double-send.
			claimed = Subscription.where(id: subscription.id)
				.where("last_forecast_sent_on IS NULL OR last_forecast_sent_on <> ?", today)
				.update_all(last_forecast_sent_on: today)
			perform_later(subscription.id) if claimed == 1
		end
	end

	private

	def get_forecast(subscription)
		api_key = Rails.application.credentials.openweathermap_api_key
		units = subscription.units == 'us' ? 'imperial' : 'metric'
		api = OpenWeatherMap::API.new(api_key)
		api.forecast(subscription.latitude, subscription.longitude, units)
	end
end
