require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
	test "lists all subscriptions on index page" do
		get :index
		assert_select 'tr.subscription', Subscription.count
	end

	test "has a 'new' form" do
		get :new
		assert_select 'form'
	end

	test "creates a new subscription with the given values" do
		post :create, subscription: { location: 'Nowheresville', email: 'test@example.com', start: '2014-01-01', end: '2014-12-31' }
		@subscription = assigns(:subscription)
		assert_equal 'Nowheresville', @subscription.location
		assert_equal 'test@example.com', @subscription.email
		assert_equal Date.parse('2014-01-01'), @subscription.start
		assert_equal Date.parse('2014-12-31'), @subscription.end
	end
end
