class DiscountCode < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :deduction_in_percent, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
end
