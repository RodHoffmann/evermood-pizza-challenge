class OrderItem < ApplicationRecord
  belongs_to :pizza
  belongs_to :size_multiplier
  belongs_to :order
end
