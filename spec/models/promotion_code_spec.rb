require 'rails_helper'

RSpec.describe PromotionCode, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:target) }
    it { should validate_inclusion_of(:target).in_array(Pizza.pluck(:name)) }
    it { should validate_presence_of(:target_size) }
    it { should validate_inclusion_of(:target_size).in_array(SizeMultiplier.pluck(:size)) }
    it { should validate_presence_of(:from) }
    it { should validate_numericality_of(:from).only_integer.is_greater_than(0) }
    it { should validate_presence_of(:to) }
    it { should validate_numericality_of(:to).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'callbacks' do
    it 'generates a valid name before validation' do
      promotion_code = build(:promotion_code, from: 2, to: 1)
      promotion_code.validate
      expect(promotion_code.name).to eq('2FOR1')
    end
  end
end
