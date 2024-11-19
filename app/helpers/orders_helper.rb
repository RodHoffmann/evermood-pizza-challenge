module OrdersHelper
  def display_promotion_codes(order)
    codes = order.promotion_codes.pluck(:name)
    codes.any? ? codes.join(', ') : '-'
  end

  def display_discount_code(order)
    order.discount_code ? order.discount_code.name : '-'
  end

  def display_pizza(order_item)
    pizza = order_item.pizza.name
    size = order_item.size_multiplier.size
    "#{pizza} (#{size})"
  end

  def display_pizza_modifications(order_item)
    modifications = %i[add remove].map { |type| modification_list(order_item, type) }
    modifications.compact.join("\n").html_safe
  end

  private

  def modification_list(order_item, type)
    modifications = order_item.order_item_ingredient_modifications.where(modification_type: type)
    return if modifications.blank?

    label = type == :add ? 'Add' : 'Remove'
    ingredients = modifications.map { |mod| mod.ingredient.name }.join(', ')
    "<li>#{label}: #{ingredients}</li>"
  end
end
