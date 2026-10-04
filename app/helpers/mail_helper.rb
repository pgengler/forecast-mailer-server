module MailHelper
	def date(timestamp)
		Time.zone.at(timestamp)
	end

	def icon_tag(icon_name)
		image_tag("https://images.pgengler.net/weather/#{icon_name}.gif")
	end

	def temperature(value, units)
		value = value.to_f
		case units
		when 'us' then "#{value.round(1)}°F"
		when 'both', 'auto' then "#{value.round(1)}°C (#{(value * 9 / 5 + 32).round(1)}°F)"
		else "#{value.round(1)}°C"
		end
	end
end
