require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { create(:order_item, :with_modifications) }
  describe 'associations' do
    it { should belong_to(:pizza) }
    it { should belong_to(:size_multiplier) }
    it { should belong_to(:order) }
    it { should have_many(:order_item_ingredient_modifications).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:pizza) }
    it { should validate_presence_of(:size_multiplier) }
    it { should validate_presence_of(:order) }
  end

  describe '#total_item_price' do
    let(:pizza) { create(:pizza, price: 10) }
    let(:size_multiplier) { create(:size_multiplier, multiplier: 2) }
    let(:order_item) { create(:order_item, pizza: pizza, size_multiplier: size_multiplier) }

    it 'calculates the correct price without modifications' do
      expect(order_item.total_item_price).to eq(20)
    end

    it 'calculates the correct price with extra ingredients' do
      ingredient1 = create(:ingredient, price: 1)
      ingredient2 = create(:ingredient, price: 2)
      create(:order_item_ingredient_modification, order_item: order_item, ingredient: ingredient1, modification_type: 'add')
      create(:order_item_ingredient_modification, order_item: order_item, ingredient: ingredient2, modification_type: 'add')

      expect(order_item.total_item_price).to eq(23) # (10 + 1 + 2) * 2
    end
  end
end
