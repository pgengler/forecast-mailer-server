class ForecastMailer < ActionMailer::Base
	add_template_helper(MailHelper)
	default from: 'weather@projects.pgengler.net'

	def daily(subscription, forecast)
		@forecast = forecast
		@location = subscription.location
		mail(to: subscription.email, subject: "Weather forecast for #{subscription.location}")
	end
end
