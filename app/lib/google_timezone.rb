require 'json'
require 'net/http'

module GoogleTimezone
	def self.lookup(latitude, longitude, api_key: Rails.application.credentials.google_maps_api_key)
		timestamp = Time.now.to_i
		url = "https://maps.googleapis.com/maps/api/timezone/json?location=#{latitude},#{longitude}&timestamp=#{timestamp}&key=#{api_key}"
		data = JSON.parse(Net::HTTP.get(URI.parse(url)))
		data['timeZoneId']
	end
end
