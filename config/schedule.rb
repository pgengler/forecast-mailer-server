every 1.day, at: '10:30am' do
	runner 'ForecastMailerWorker.send_forecast_emails'
end
