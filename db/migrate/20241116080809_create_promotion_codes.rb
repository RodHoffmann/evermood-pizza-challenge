class CreatePromotionCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :promotion_codes, id: :uuid do |t|
      t.string :name
      t.string :target
      t.string :target_size
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end
end
