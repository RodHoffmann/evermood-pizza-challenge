class Order < ApplicationRecord
  belongs_to :discount_code, optional: true
  has_many :order_items, dependent: :destroy
  has_many :order_item_ingredient_modifications, through: :order_items, dependent: :destroy
  has_many :ingredients, through: :order_item_ingredient_modifications
  has_many :pizzas, through: :order_items
  has_many :order_promotion_codes, dependent: :destroy
  has_many :promotion_codes, through: :order_promotion_codes
  has_many :size_multipliers, through: :order_items

  def self.open_orders
    Order.where(state: 'OPEN')
  end

  def total_price
    price_before_discount_and_promotions = order_items.sum(&:total_item_price)
    price_before_discount = apply_promotion_codes(price_before_discount_and_promotions)
    discount_code ? apply_discount_code(price_before_discount).round(2) : price_before_discount.round(2)
  end

  private

  def apply_promotion_codes(price_before_discount_and_promotions)
    promotion_codes&.each do |promotion_code|
      target_pizza = promotion_code.target
      target_size = promotion_code.target_size
      from = promotion_code.from
      to = promotion_code.to
      target_pizza_price = Pizza.where(name: target_pizza).first.price * SizeMultiplier.where(size: target_size).first.multiplier
      number_target_pizzas = order_items
                             .joins(:pizza, :size_multiplier)
                             .where(pizzas: { name: target_pizza }, size_multipliers: { size: target_size })
                             .count
      if number_target_pizzas.positive? && number_target_pizzas >= from
        price_before_discount_and_promotions -= ((number_target_pizzas / from) * to) * target_pizza_price
      end
    end
    price_before_discount_and_promotions
  end

  def apply_discount_code(price_before_discount)
    price_before_discount * (1 - discount_code.deduction_in_percent / 100)
  end
end
