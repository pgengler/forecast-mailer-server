class AddLatitudeAndLongitudeToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :latitude, :float
    add_column :subscriptions, :longitude, :float
  end
end
