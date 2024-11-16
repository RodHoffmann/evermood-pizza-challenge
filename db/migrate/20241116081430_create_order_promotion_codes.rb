class CreateOrderPromotionCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :order_promotion_codes, id: :uuid do |t|
      t.references :promotion_code, null: false, type: :uuid, foreign_key: true
      t.references :order, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
