class CreateSubscriptions < ActiveRecord::Migration[4.2]
  def change
    create_table :subscriptions do |t|
      t.string :location
      t.date :start
      t.date :end
      t.string :email

      t.timestamps
    end
  end
end
