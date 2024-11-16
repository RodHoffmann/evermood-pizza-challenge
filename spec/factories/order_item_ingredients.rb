FactoryBot.define do
  factory :order_item_ingredient do
    ingredient_presence_status { false }
    ingredient { nil }
    order_item { nil }
  end
end
