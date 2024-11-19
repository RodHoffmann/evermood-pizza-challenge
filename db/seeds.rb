# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Main flow at the end of the file
def destroy_all_data
  puts 'Destroying all data...'
  [OrderPromotionCode, PromotionCode, OrderItemIngredientModification, OrderItem, Order,
   DiscountCode, SizeMultiplier, Ingredient, Pizza].each(&:destroy_all)
  puts 'All data destroyed successfully'
end

def parse_initial_data
  puts 'Parsing and storing config.yml file...'
  YAML.load_file('db/initial_data/config.yml', symbolize_names: true).tap do
    puts 'Parsing success!'
  end
end

def create_ingredients(data)
  puts 'Creating ingredients...'
  data[:ingredients].each do |name, price|
    Ingredient.create!(name: name, price: price.to_f.round(2))
  end
  puts 'Ingredients created successfully'
end

def create_pizzas(data)
  puts 'Creating Pizzas...'
  data[:pizzas].each do |name, price|
    Pizza.create!(name: name, price: price.to_f.round(2))
  end
  puts 'Pizzas created successfully'
end

def create_size_multipliers(data)
  puts 'Creating Size Multipliers...'
  data[:size_multipliers].each do |size, multiplier|
    SizeMultiplier.create!(size: size, multiplier: multiplier)
  end
  puts 'Sizes Multipliers created successfully'
end

def create_promotions(data)
  puts 'Creating Promotions...'
  data[:promotions].each do |name, specs|
    PromotionCode.create!(
      name: name,
      target: specs[:target],
      target_size: specs[:target_size],
      from: specs[:from].to_i,
      to: specs[:to].to_i
    )
  end
  puts 'Promotions created successfully'
end

def create_discounts(data)
  puts 'Creating Discounts...'
  data[:discounts].each do |name, specs|
    DiscountCode.create!(name: name, deduction_in_percent: specs[:deduction_in_percent].to_f.round(2))
  end
  puts 'Discounts created successfully'
end

def parse_orders
  puts 'Parsing and storing orders.json file...'
  JSON.load_file('db/initial_data/orders.json', symbolize_names: true).tap do
    puts 'Parsing orders success!'
  end
end

def create_orders(orders_data)
  puts 'Creating Orders...'
  orders_data.each do |order_data|
    promotion_codes = PromotionCode.where(name: order_data[:promotionCodes])
    discount_code = DiscountCode.find_by(name: order_data[:discountCode])

    new_order = Order.create!(
      id: order_data[:id],
      created_at: Time.parse(order_data[:createdAt]),
      updated_at: Time.parse(order_data[:createdAt]),
      state: order_data[:state],
      discount_code: discount_code
    )

    order_data[:items].each do |item|
      pizza = Pizza.find_by(name: item[:name])
      size_multiplier = SizeMultiplier.find_by(size: item[:size])

      order_item = OrderItem.create!(pizza: pizza, size_multiplier: size_multiplier, order: new_order)

      item[:add]&.each do |add_ingredient|
        OrderItemIngredientModification.create!(
          order_item: order_item,
          ingredient: Ingredient.find_by(name: add_ingredient),
          modification_type: 'add'
        )
      end

      item[:remove]&.each do |remove_ingredient|
        OrderItemIngredientModification.create!(
          order_item: order_item,
          ingredient: Ingredient.find_by(name: remove_ingredient),
          modification_type: 'remove'
        )
      end
    end

    promotion_codes&.each do |promotion_code|
      OrderPromotionCode.create!(promotion_code: promotion_code, order: new_order)
    end

    new_order.save!
  end
  puts 'Orders created successfully'
end

# Main execution flow
# Uncomment the following line to run clean the database before seeding
destroy_all_data
initial_data = parse_initial_data
create_ingredients(initial_data)
create_pizzas(initial_data)
create_size_multipliers(initial_data)
create_promotions(initial_data)
create_discounts(initial_data)

initial_orders = parse_orders
create_orders(initial_orders)

puts "\nAll initial data migrated into the Database\n"
