module OrdersHelper
  def display_promotion_codes(order)
    codes = order.promotion_codes.pluck(:name)
    codes.any? ? codes.join(', ') : '-'
  end

  def display_discount_code(order)
    order.discount_code ? order.discount_code.name : '-'
  end
end
