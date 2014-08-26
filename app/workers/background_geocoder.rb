class BackgroundGeocoder
	include Sidekiq::Worker

	def perform(subscription_id)
		subscription = Subscription.find(subscription_id)
		subscription.geocode
		if subscription.geocoded?
			subscription.save
		else
			raise Geocoder::OverQueryLimitError
		end
	end
end
