class CreateSizeMultipliers < ActiveRecord::Migration[7.1]
  def change
    create_table :size_multipliers, id: :uuid do |t|
      t.string :size
      t.decimal :multiplier, precision: 10, scale: 2

      t.timestamps
    end
  end
end
