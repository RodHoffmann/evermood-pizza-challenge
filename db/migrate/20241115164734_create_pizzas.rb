class CreatePizzas < ActiveRecord::Migration[7.1]
  def change
    create_table :pizzas, id: :uuid do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
