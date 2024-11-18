FactoryBot.define do
  factory :order_promotion_code do
    association :order
    association :promotion_code
  end
end
