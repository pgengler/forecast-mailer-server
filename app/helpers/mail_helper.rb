module MailHelper
	def date(timestamp)
		Time.zone.at(timestamp)
	end
end
