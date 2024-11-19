require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order, :with_items) }

  describe 'validations' do
    it { should validate_presence_of(:state) }
    it { should validate_inclusion_of(:state).in_array(%w[OPEN CLOSED]) }
  end

  describe 'associations' do
    it { should have_many(:order_items).dependent(:destroy) }
    it { should have_many(:promotion_codes).through(:order_promotion_codes) }
  end

  describe '.open_orders_with_details' do
    it 'returns only orders with state OPEN' do
      create(:order, state: 'CLOSED')
      create(:order, state: 'OPEN')
      expect(Order.open_orders_with_details.count(:id)).to eq(1)
    end
  end

  describe '#total_price' do
    it 'calculates the correct total price for an order' do
      expect(order.calculate_total_price).to be_within(0.01).of(order.order_items.sum(&:total_item_price))
    end

    it 'applies discount codes correctly' do
      discount_code = create(:discount_code, deduction_in_percent: 10)
      order.update(discount_code: discount_code)
      expect(order.calculate_total_price).to be_within(0.01).of(order.order_items.sum(&:total_item_price) * 0.9)
    end

    it 'after applying promotion codes, total price should be equal or less than' do
      promotion_code = build(:promotion_code, target: order.order_items.first.pizza.name,
                                              target_size: order.order_items.first.size_multiplier.size,
                                              from: 2,
                                              to: 1)
      build(:order_promotion_code, order: order, promotion_code: promotion_code)
      expect(order.calculate_total_price).to be <= order.order_items.sum(&:total_item_price).round(2)
    end
  end
end
