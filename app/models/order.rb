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
    open_orders = Order.where(state: 'OPEN')
  end

  private


end
