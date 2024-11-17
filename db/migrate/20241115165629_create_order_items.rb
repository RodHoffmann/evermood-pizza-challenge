class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items, id: :uuid do |t|
      t.references :pizza, null: false, type: :uuid, foreign_key: true
      t.references :size_multiplier, null: false, type: :uuid, foreign_key: true
      t.references :order, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
