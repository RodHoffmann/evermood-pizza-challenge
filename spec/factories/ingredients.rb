FactoryBot.define do
  factory :ingredient do
    sequence(:name) { |n| "Ingredient#{n}" }
    price { Faker::Commerce.price(range: 0.5..3.0) }
  end
end
