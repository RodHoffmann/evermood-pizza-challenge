class PromotionCode < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :target, presence: true, inclusion: { in: Pizza.pluck(:name) }
  validates :target_size, presence: true, inclusion: { in: SizeMultiplier.pluck(:size) }
  validates :from, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :to, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
