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

	test "redirects to index after creating a new subscription" do
		post :create, subscription: { location: 'Over there', email: 'example@example.com' }
		assert_response :redirect
		assert_redirected_to subscriptions_path
	end

	test "shows an 'edit' form" do
		get :edit, id: subscriptions(:no_dates)
		assert_response :success
		assert_select 'form'
	end

	test "can update values for a subscription" do
		put :update, id: subscriptions(:no_dates), subscription: { email: 'nobody@example.com', location: 'The Middle of Somewhere', start: '2014-01-01', end: '2014-02-01' }

		subscription = assigns(:subscription)
		assert_equal 'nobody@example.com', subscription.email
		assert_equal 'The Middle of Somewhere', subscription.location
		assert_equal Date.parse('2014-01-01'), subscription.start
		assert_equal Date.parse('2014-02-01'), subscription.end
	end

	test "can delete a subscription" do
		assert_difference 'Subscription.count', -1 do
			delete :destroy, id: subscriptions(:no_dates)
		end
	end
end
