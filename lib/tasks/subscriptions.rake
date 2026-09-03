namespace :subscriptions do
	desc "Backfill timezone for geocoded subscriptions missing one"
	task backfill_timezones: :environment do
		Subscription.where(timezone: nil).where.not(latitude: nil).find_each do |subscription|
			subscription.update_column(:timezone, GoogleTimezone.lookup(subscription.latitude, subscription.longitude))
		end
	end
end
