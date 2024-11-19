FactoryBot.define do
  factory :size_multiplier do
    sequence(:size) { |n| "Size#{n}" }
    multiplier { Faker::Number.decimal(l_digits: 1, r_digits: 1) }
  end
end
