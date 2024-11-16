FactoryBot.define do
  factory :order_promotion_code do
    promotion_code { nil }
    order { nil }
  end
end
