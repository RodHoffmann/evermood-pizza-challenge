class OrderItem < ApplicationRecord
  belongs_to :pizza
  belongs_to :size_multiplier
  belongs_to :order
  has_many :order_item_ingredient_modifications, dependent: :destroy
end
