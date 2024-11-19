class CreateOrderItemIngredientModifications < ActiveRecord::Migration[7.1]
  def change
    create_table :order_item_ingredient_modifications, id: :uuid do |t|
      t.string :modification_type
      t.references :ingredient, null: false, type: :uuid, foreign_key: true
      t.references :order_item, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
