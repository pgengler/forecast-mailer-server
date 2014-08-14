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
end
