class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :state
      t.references :discount_code, null: true, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
