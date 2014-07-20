require 'active_support/all'
require 'forecast_io'

def date(timestamp)
	Time.zone.at(timestamp)
end

def temperature(value)
	"#{value}°C"
end

latitude = ARGV[0]
longitude = ARGV[1]

ForecastIO.configure do |config|
	config.api_key = ENV['FORECASTIO_API_KEY']
	config.default_params = { units: 'si' }
end

forecast = ForecastIO.forecast(latitude, longitude)
Time.zone = forecast.timezone
forecast.daily["data"].each do |f|
	puts "Date: #{date(f.time).strftime('%A, %B %d')}"
	puts "Summary: #{f.summary}"
	puts "High temperature: #{temperature(f.temperatureMax)}"
	puts "Low temperature: #{temperature(f.temperatureMin)}"
	puts "Chance of precipitation: #{(f.precipProbability*100).to_i}%"
	puts "Sunrise: #{date(f.sunriseTime).strftime('%H:%M')}"
	puts "Sunset: #{date(f.sunsetTime).strftime('%H:%M')}"
	puts
end
