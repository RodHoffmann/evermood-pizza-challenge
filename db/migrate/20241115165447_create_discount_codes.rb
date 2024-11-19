class CreateDiscountCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :discount_codes, id: :uuid do |t|
      t.string :name
      t.decimal :deduction_in_percent, precision: 4, scale: 2

      t.timestamps
    end
  end
end
