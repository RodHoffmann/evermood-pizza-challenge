class OrderItemIngredientModification < ApplicationRecord
  belongs_to :ingredient
  belongs_to :order_item
  validates :modification_type, inclusion: { in: %w[add remove] }
  validates :ingredient, :order_item, :modification_type, presence: true
end
