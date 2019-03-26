class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string  :ref
      t.string  :purchase_channel
      t.string  :client_name
      t.string  :address
      t.string  :delivery_srvc
      t.decimal :value, precision: 7 ,scale: 2
      t.string  :line_items
      t.string  :status

      t.timestamps
    end
  end
end
