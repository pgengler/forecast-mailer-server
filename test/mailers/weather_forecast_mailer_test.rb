require 'test_helper'

class WeatherForecastMailerTest < ActionMailer::TestCase
	test "daily email shows temperatures in both Celsius and Fahrenheit for 'both' units" do
		subscription = Subscription.new(email: 'test@example.com', location: 'Somewhere', units: 'both')
		forecast = OpenWeatherMap::Forecast.new(JSON.generate(
			'timezone' => 'UTC',
			'daily' => [{
				'dt' => 1_756_976_400,
				'sunrise' => 1_756_976_400,
				'sunset' => 1_756_976_400,
				'temp' => { 'min' => 8.04, 'max' => 17.21 },
				'pop' => 0.2,
				'weather' => [{ 'icon' => '01d', 'description' => 'clear sky' }]
			}]
		))

		mail = WeatherForecastMailer.daily(subscription, forecast)

		assert_includes mail.body.to_s, 'High: 17.2°C (63.0°F)'
		assert_includes mail.body.to_s, 'Low: 8.0°C (46.5°F)'
	end
end
