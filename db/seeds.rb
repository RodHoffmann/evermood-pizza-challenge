# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Uncomment following lines to delete all data first
puts 'Destroying all data...'
PizzaIngredient.destroy_all
OrderPromotionCode.destroy_all
PromotionCode.destroy_all
DiscountCode.destroy_all
Order.destroy_all
OrderItemIngredientModification.destroy_all
OrderItem.destroy_all
SizeMultiplier.destroy_all
Ingredient.destroy_all
Pizza.destroy_all
puts 'All data destroyed successfully'

puts 'Parsing config.yml file...'
initial_data = YAML.load_file('db/initial_data/config.yml')
sizes_and_multipliers = initial_data['size_multipliers']
pizzas_names_and_prices = initial_data['pizzas']
pizza_ingredients_names_and_prices = initial_data['ingredients']
promotions_name_and_specs = initial_data['promotions']
discounts_name_and_percentage = initial_data['discounts']
puts 'Parsing success!'
puts 'Creating ingredients...'
pizza_ingredients_names_and_prices.each { |name, price| Ingredient.create!(name: name, price: price.to_f.round(2)) }
puts 'Ingredients created successfully'
puts 'Creating Pizzas...'
pizzas_names_and_prices.each { |name, price| Pizza.create!(name: name, price: price.to_f.round(2)) }
puts 'Pizzas created successfully'
puts 'Creating Size Multipliers...'
sizes_and_multipliers.each { |size, multiplier| SizeMultiplier.create!(size: size, multiplier: multiplier) }
puts 'Sizes Multipliers created successfully'
puts 'Creating Promotions...'
promotions_name_and_specs.each do |name, specs|
  PromotionCode.create!(name: name,
                        target: specs['target'],
                        target_size: specs['target_size'],
                        from: specs['from'].to_i,
                        to: specs['to'].to_i)
end
puts 'Promotions created successfully'
puts 'Creating Discounts'
discounts_name_and_percentage.each do |name, specs|
  DiscountCode.create!(name: name, deduction_in_percent: specs['deduction_in_percent'].to_f.round(2))
end
puts 'Discounts created successfully'
puts "\nAll initial data migrated into the Database\n"
