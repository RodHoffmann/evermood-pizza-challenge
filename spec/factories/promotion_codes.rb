FactoryBot.define do
  factory :promotion_code do
    from { Faker::Number.between(from: 2, to: 5) }
    to { Faker::Number.between(from: 1, to: from - 1) }
    target { Pizza.pluck(:name).sample || create(:pizza).name }
    target_size { SizeMultiplier.pluck(:size).sample || create(:size_multiplier).size }

    after(:build) do |promotion_code|
      promotion_code.name = "#{promotion_code.from}FOR#{promotion_code.to}"
    end
  end
end
