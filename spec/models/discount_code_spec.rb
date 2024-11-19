require 'rails_helper'

RSpec.describe DiscountCode, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:deduction_in_percent) }
    it { should validate_numericality_of(:deduction_in_percent).is_greater_than(0).is_less_than_or_equal_to(100) }
  end
end
