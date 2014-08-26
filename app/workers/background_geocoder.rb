class BackgroundGeocoder
	include Sidekiq::Worker

	def perform(id)
		obj = Subscription.find(id)
		obj.geocode
		if obj.geocoded?
			obj.save
		else
			raise Geocoder::OverQueryLimitError
		end
	end
end
