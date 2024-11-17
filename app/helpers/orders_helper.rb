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
    additions = order_item.order_item_ingredient_modifications.where(modification_type: 'add')
    removals = order_item.order_item_ingredient_modifications.where(modification_type: 'remove')
    additions = "<li>Add: #{additions&.map { |ingredient| ingredient.ingredient.name }.join(', ')}</li>" if additions.present?
    removals = "<li>Remove: #{removals&.map { |ingredient| ingredient.ingredient.name }.join(', ')}</li>" if removals.present?
    [additions, removals].compact.join("\n").html_safe
  end
end
