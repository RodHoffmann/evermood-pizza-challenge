FactoryBot.define do
  factory :order_item_ingredient_modification do
    association :ingredient
    association :order_item
    modification_type { %w[add remove].sample }
  end
end
