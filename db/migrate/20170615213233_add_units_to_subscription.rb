class AddUnitsToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :units, :string, null: false, default: 'si'
  end
end
