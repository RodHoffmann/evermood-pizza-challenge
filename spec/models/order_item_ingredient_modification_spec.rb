require 'rails_helper'

RSpec.describe OrderItemIngredientModification, type: :model do
  describe 'associations' do
    it { should belong_to(:ingredient) }
    it { should belong_to(:order_item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:ingredient) }
    it { should validate_presence_of(:order_item) }
    it { should validate_presence_of(:modification_type) }
    it { should validate_inclusion_of(:modification_type).in_array(%w[add remove]) }
  end
end
