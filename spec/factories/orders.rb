FactoryBot.define do
  factory :order do
    state { 'OPEN' }

    trait :closed do
      state { 'CLOSED' }
    end

    trait :with_items do
      transient do
        items_count { 2 }
      end

      after(:create) do |order, evaluator|
        create_list(:order_item, evaluator.items_count, order: order)
      end
    end

    trait :with_discount_code do
      association :discount_code
    end

    trait :with_promotion_codes do
      transient do
        promotion_codes_count { 1 }
      end

      after(:create) do |order, evaluator|
        create_list(:order_promotion_code, evaluator.promotion_codes_count, order: order)
      end
    end
  end
end
