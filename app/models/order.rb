class Order < ApplicationRecord
  belongs_to :discount_code, optional: true
  has_many :order_items, dependent: :destroy
  has_many :order_item_ingredient_modifications, through: :order_items, dependent: :destroy
  has_many :ingredients, through: :order_item_ingredient_modifications
  has_many :pizzas, through: :order_items
  has_many :order_promotion_codes, dependent: :destroy
  has_many :promotion_codes, through: :order_promotion_codes
  has_many :size_multipliers, through: :order_items
  validates :state, presence: true, inclusion: { in: %w[OPEN CLOSED] }

  before_save :set_total_price, if: :needs_price_update?

  def self.open_orders_with_details
    open_orders_with_details_query
  end

  private

  def set_total_price
    self.total_price = calculate_total_price
  end

  def self.open_orders_with_details_query
    Order
      .where(state: 'OPEN')
      .includes(:promotion_codes,
                :discount_code,
                order_items: [
                  :pizza,
                  :size_multiplier,
                  { order_item_ingredient_modifications: :ingredient }
                ])
      .select(:id, :created_at, :total_price, :discount_code_id)
  end
  private_class_method :open_orders_with_details_query

  def needs_price_update?
    order_items.any? || promotion_codes.any?
  end

  def calculate_total_price
    price_before_discount_and_promotions = order_items.sum(&:total_item_price)
    price_before_discount = apply_promotion_codes(price_before_discount_and_promotions)
    discount_code ? apply_discount_code(price_before_discount).round(2) : price_before_discount.round(2)
  end

  def apply_discount_code(price_before_discount)
    price_before_discount * (1 - discount_code.deduction_in_percent / 100)
  end

  def apply_promotion_codes(price_before_discount_and_promotions)
    promotion_codes&.each do |promotion_code|
      price_before_discount_and_promotions -= calculate_discount(promotion_code)
    end
    price_before_discount_and_promotions
  end

  def calculate_discount(promotion_code)
    target_pizza_price = calculate_target_pizza_price(promotion_code)
    number_target_pizzas = count_target_pizzas(promotion_code)

    return 0 unless eligible_for_discount?(number_target_pizzas, promotion_code.from)

    discount_multiplier = (number_target_pizzas / promotion_code.from) * promotion_code.to
    discount_multiplier * target_pizza_price
  end

  def calculate_target_pizza_price(promotion_code)
    pizza = Pizza.find_by(name: promotion_code.target)
    size_multiplier = SizeMultiplier.find_by(size: promotion_code.target_size)

    return 0 unless pizza && size_multiplier

    pizza.price * size_multiplier.multiplier
  end

  def count_target_pizzas(promotion_code)
    order_items
      .joins(:pizza, :size_multiplier)
      .where(pizzas: { name: promotion_code.target }, size_multipliers: { size: promotion_code.target_size })
      .count
  end

  def eligible_for_discount?(number_target_pizzas, from)
    number_target_pizzas.positive? && number_target_pizzas >= from
  end
end
