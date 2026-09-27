require 'test_helper'

class ForecastMailerWorkerTest < ActiveSupport::TestCase
	setup do
		@enqueued = []
		enqueued = @enqueued
		ForecastMailerWorker.define_singleton_method(:perform_later) do |id|
			enqueued << id
		end
	end

	def enqueue_subscription(timezone:, last_sent_on: nil, latitude: 0.0, longitude: 0.0)
		Subscription.create!(
			email: 'test@example.com',
			location: 'Somewhere',
			latitude: latitude,
			longitude: longitude,
			timezone: timezone,
			last_forecast_sent_on: last_sent_on
		)
	end

	test "enqueues subscription whose local hour is 6 and not yet sent today" do
		subscription = enqueue_subscription(timezone: 'UTC')
		travel_to Time.utc(2026, 9, 2, 6, 5, 0) do
			ForecastMailerWorker.send_forecast_emails
		end
		assert_includes @enqueued, subscription.id
		assert_equal Date.new(2026, 9, 2), subscription.reload.last_forecast_sent_on
	end

	test "does not re-enqueue a subscription already sent today (local)" do
		subscription = enqueue_subscription(timezone: 'UTC', last_sent_on: Date.new(2026, 9, 2))
		travel_to Time.utc(2026, 9, 2, 6, 30, 0) do
			ForecastMailerWorker.send_forecast_emails
		end
		refute_includes @enqueued, subscription.id
	end

	test "skips subscription whose local hour is not 6" do
		subscription = enqueue_subscription(timezone: 'UTC')
		travel_to Time.utc(2026, 9, 2, 7, 0, 0) do
			ForecastMailerWorker.send_forecast_emails
		end
		refute_includes @enqueued, subscription.id
		assert_nil subscription.reload.last_forecast_sent_on
	end

	test "skips subscription with no timezone" do
		subscription = enqueue_subscription(timezone: nil)
		travel_to Time.utc(2026, 9, 2, 6, 0, 0) do
			ForecastMailerWorker.send_forecast_emails
		end
		refute_includes @enqueued, subscription.id
		assert_nil subscription.reload.last_forecast_sent_on
	end

	test "respects non-UTC offset zones" do
		# New York is UTC-4 (EDT) in September: 6am local == 10:00 UTC.
		subscription = enqueue_subscription(timezone: 'America/New_York')
		travel_to Time.utc(2026, 9, 2, 10, 0, 0) do
			ForecastMailerWorker.send_forecast_emails
		end
		assert_includes @enqueued, subscription.id
		assert_equal Date.new(2026, 9, 2), subscription.reload.last_forecast_sent_on
	end
end
