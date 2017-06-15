class AddLatitudeAndLongitudeToSubscription < ActiveRecord::Migration[4.2]
  def change
    add_column :subscriptions, :latitude, :float
    add_column :subscriptions, :longitude, :float
  end
end
