require 'json'
require 'net/http'

module GoogleTimezone
	class Error < StandardError; end

	def self.lookup(latitude, longitude, api_key: Rails.application.credentials.google_maps_api_key)
		timestamp = Time.now.to_i
		url = "https://maps.googleapis.com/maps/api/timezone/json?location=#{latitude},#{longitude}&timestamp=#{timestamp}&key=#{api_key}"
		data = JSON.parse(Net::HTTP.get(URI.parse(url)))
		status = data['status']
		if status != 'OK'
			raise Error, "Google Time Zone API returned #{status}: #{data['errorMessage'] || '(no message)'} for (#{latitude}, #{longitude})"
		end
		data['timeZoneId']
	end
end
