FactoryBot.define do
  factory :discount_code do
    sequence(:name) { |n| "SAVE#{n}" }
    deduction_in_percent { Faker::Number.between(from: 5, to: 50) }
  end
end
