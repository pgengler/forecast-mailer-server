require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
	test "requires location" do
		assert_raises ActiveRecord::RecordInvalid do
		Subscription.create! email: 'test@example.com', start: 1.day.ago, end: 1.day.from_now
		end
	end
end
