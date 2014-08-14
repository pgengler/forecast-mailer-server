require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
	test "requires location" do
		assert_raises ActiveRecord::RecordInvalid do
			Subscription.create! email: 'test@example.com', start: 1.day.ago, end: 1.day.from_now
		end
	end

	test "requires email" do
		assert_raises ActiveRecord::RecordInvalid do
			Subscription.create! location: 'New York, NY', start: 1.day.ago, end: 1.day.from_now
		end
	end

	test "does not require start or end" do
		assert_difference 'Subscription.count' do
			Subscription.create! location: 'Rome', email: 'test@example.com'
		end
	end
end
