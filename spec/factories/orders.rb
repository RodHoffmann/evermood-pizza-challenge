FactoryBot.define do
  factory :order do
    state { "MyString" }
    discount_code { nil }
  end
end
