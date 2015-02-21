class BackgroundGeocoder
	include Sidekiq::Worker

	def perform(subscription_id)
		return unless subscription_id
		subscription = Subscription.find(subscription_id)
		return unless subscription
		subscription.geocode
		if subscription.geocoded?
			subscription.save
		else
			raise Geocoder::OverQueryLimitError
		end
	end
end
