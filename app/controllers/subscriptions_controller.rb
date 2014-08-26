class SubscriptionsController < ApplicationController
	def index
		@subscriptions = Subscription.all
	end

	def new
		@subscription = Subscription.new
	end

	def create
		@subscription = Subscription.create!(subscription_params)
		redirect_to subscriptions_path
	end

	def edit
		@subscription = Subscription.find(params[:id])
	end

	def update
		@subscription = Subscription.find(params[:id])
		@subscription.update!(subscription_params)
	end

	private

	def subscription_params
		params.require(:subscription).permit(:email, :end, :location, :start)
	end
end
