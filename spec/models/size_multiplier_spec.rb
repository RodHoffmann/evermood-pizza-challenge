require 'rails_helper'

RSpec.describe SizeMultiplier, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:size) }
    it { should validate_uniqueness_of(:size) }
    it { should validate_presence_of(:multiplier) }
  end
end
