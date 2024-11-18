require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { create(:order_item, :with_modifications) }

  describe 'validations' do
    it { should validate_presence_of(:pizza) }
    it { should validate_presence_of(:size_multiplier) }
    it { should validate_presence_of(:order) }
  end

  describe '#total_item_price' do
    it 'calculates price with extra ingredients' do
      extra_ingredients_price = order_item.order_item_ingredient_modifications
                                          .where(modification_type: 'add')
                                          .joins(:ingredient)
                                          .sum('ingredients.price')
      expected_price = (order_item.pizza.price + extra_ingredients_price) * order_item.size_multiplier.multiplier
      expect(order_item.total_item_price).to eq(expected_price)
    end
  end
end
