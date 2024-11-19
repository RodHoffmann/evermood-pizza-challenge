class SizeMultiplier < ApplicationRecord
  validates :size, presence: true, uniqueness: true
  validates :multiplier, presence: true
end
