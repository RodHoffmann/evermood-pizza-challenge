class CreatePizzaIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :pizza_ingredients, id: :uuid do |t|
      t.references :pizza, null: false, type: :uuid, foreign_key: true
      t.references :ingredient, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
