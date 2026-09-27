namespace :subscriptions do
	desc "Backfill timezone for geocoded subscriptions missing one"
	task backfill_timezones: :environment do
		scope = Subscription.where(timezone: nil).where.not(latitude: nil)
		total = scope.count
		puts "Backfilling timezone for #{total} subscription(s)..."
		done = 0
		scope.find_each do |subscription|
			tz = GoogleTimezone.lookup(subscription.latitude, subscription.longitude)
			subscription.update_column(:timezone, tz)
			done += 1
			puts "  [#{done}/#{total}] subscription=#{subscription.id} (#{subscription.latitude},#{subscription.longitude}) -> #{tz.inspect}"
		end
		puts "Done. #{done} subscription(s) processed."
	end
end
