class WeatherForecastMailer < ActionMailer::Base
	add_template_helper(MailHelper)
	default from: 'Weather Forecast <weather@projects.pgengler.net>'

	def daily(subscription, forecast)
		@forecast = forecast
		@location = subscription.location
		@temperature_unit = case subscription.units
		when 'ca', 'uk2', 'si'
			'C'
		when 'us'
			'F'
		end
		mail(to: subscription.email, subject: "Weather forecast for #{subscription.location}")
	end
end
