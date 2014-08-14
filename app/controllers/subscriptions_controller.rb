class SubscriptionsController < ApplicationController
	def index
		@subscriptions = Subscription.all
	end

	def new
		@subscription = Subscription.new
	end

	def create
		@subscription = Subscription.create!(subscription_params)
	end

	private

	def subscription_params
		params.require(:subscription).permit(:email, :end, :location, :start)
	end
end
