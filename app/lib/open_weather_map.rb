require 'date'
require 'json'
require 'net/http'

module OpenWeatherMap
  class API
    def initialize(api_key)
      @api_key = api_key
    end

    def forecast(latitude, longitude, units)
      url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{latitude}&lon=#{longitude}&units=#{units}&exclude=current,minutely,hourly,alerts&appid=#{@api_key}"

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
      when '01'
        'clear-day'
      when '02', '03'
        'partly-cloudy-day'
      when '04'
        'cloudy'
      when '09', '10', '11'
        'rain'
      when '13'
        'snow'
      when '50'
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
