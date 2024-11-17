class OrderItem < ApplicationRecord
  belongs_to :pizza
  belongs_to :size_multiplier
  belongs_to :order
  has_many :order_item_ingredient_modifications, dependent: :destroy

  def total_item_price
    price_for_extra_ingredients = order_item_ingredient_modifications
                                  .where(modification_type: 'add')
                                  .joins(:ingredient)
                                  .sum('ingredients.price') || 0
    (pizza.price + price_for_extra_ingredients) * size_multiplier.multiplier
  end
end
