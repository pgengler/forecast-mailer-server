module MailHelper
	def date(timestamp)
		Time.zone.at(timestamp)
	end

	def icon_tag(icon_name)
		image_tag("https://openweathermap.org/img/wn/#{icon_name}@2x.png")
	end
end
