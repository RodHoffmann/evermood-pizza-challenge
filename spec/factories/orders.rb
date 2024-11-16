FactoryBot.define do
  factory :order do
    state { "MyString" }
    discount_code { nil }
    order_item { nil }
  end
end
