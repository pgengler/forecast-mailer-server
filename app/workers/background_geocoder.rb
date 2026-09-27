class BackgroundGeocoder < ApplicationJob
	def perform(subscription_id)
		return unless subscription_id
		subscription = Subscription.find(subscription_id)
		return unless subscription
		subscription.geocode
		if subscription.geocoded?
			subscription.timezone = GoogleTimezone.lookup(subscription.latitude, subscription.longitude)
			subscription.save
		else
			raise Geocoder::OverQueryLimitError
		end
	end
end
