class CreateJoinTableOrdersBatches < ActiveRecord::Migration[5.2]
  def change
    create_join_table :Orders, :Batches do |t|
      # t.index [:order_id, :batch_id]
      # t.index [:batch_id, :order_id]
    end
  end
end
