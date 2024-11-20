require 'date'
require 'json'
require 'net/http'

module OpenWeatherMap
  class API
    def initialize(api_key)
      @api_key = api_key
    end

    def forecast(latitude, longitude, units)
      url = "https://api.openweathermap.org/data/3.0/onecall?lat=#{latitude}&lon=#{longitude}&units=#{units}&exclude=current,minutely,hourly,alerts&appid=#{@api_key}"

      response = Net::HTTP.get(URI.parse(url))

      Forecast.new(response)
    end
  end

  class Forecast
    def initialize(api_response)
      @response = JSON.parse(api_response)
    end

    def days
      @response['daily'].map { |day| ForecastDay.new(day) }
    end

    def timezone
      @response['timezone']
    end
  end

  class ForecastDay
    def initialize(data)
      @data = data
    end

    def date
      DateTime.strptime(@data['dt'].to_s, '%s')
    end

    def icon
      case @data['weather'].first['icon']
      when '01d'
        'clear-day'
      when '01n'
        'clear-night'
      when '02d', '03d'
        'partly-cloudy-day'
      when '02n', '03n'
        'party-cloudy-night'
      when '04d'
        'cloudy'
      when '09d', '10d', '11d'
        'rain'
      when '13d'
        'snow'
      when '50d'
        'fog'
      end
    end

    def summary
      @data['weather'].first['description']
    end

    def low
      @data['temp']['min']
    end

    def high
      @data['temp']['max']
    end

    def precipitation_probability
      @data['pop']
    end

    def sunrise
      Time.at @data['sunrise']
    end

    def sunset
      Time.at @data['sunset']
    end
  end
end
