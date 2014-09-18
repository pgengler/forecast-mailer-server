module MailHelper
	def date(timestamp)
		Time.zone.at(timestamp)
	end

	def icon_tag(icon_name)
		image_tag("http://images.pgengler.net/weather/#{icon_name}.gif")
	end
end
