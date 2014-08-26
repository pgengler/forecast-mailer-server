class ForecastMailer < ActionMailer::Base
	def daily(subscription, forecast)
		@forecast = forecast
		@location = subscription.location
		mail(to: subscription.email, subject: "Weather forecast for #{subscription.location}")
	end
end
