FactoryBot.define do
  factory :order_item do
    association :order
    association :pizza
    association :size_multiplier

    trait :with_modifications do
      transient do
        add_ingredients_count { 2 }
        remove_ingredients_count { 1 }
      end

      after(:create) do |order_item, evaluator|
        create_list(:order_item_ingredient_modification, evaluator.add_ingredients_count,
                    order_item: order_item, modification_type: 'add')
        create_list(:order_item_ingredient_modification, evaluator.remove_ingredients_count,
                    order_item: order_item, modification_type: 'remove')
      end
    end
  end
end
