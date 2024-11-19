FactoryBot.define do
  factory :pizza do
    sequence(:name) { |n| "Pizza#{n}" }
    price { Faker::Commerce.price(range: 2.0..15.0) }
  end
end
