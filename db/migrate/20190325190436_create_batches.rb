class CreateBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :batches do |t|
      t.string :ref
      t.string :purchase_channel

      t.timestamps
    end
  end
end
