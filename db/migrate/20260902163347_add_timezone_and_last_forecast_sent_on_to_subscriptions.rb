class AddTimezoneAndLastForecastSentOnToSubscriptions < ActiveRecord::Migration[8.1]
	def change
		add_column :subscriptions, :timezone, :string
		add_column :subscriptions, :last_forecast_sent_on, :date
	end
end
