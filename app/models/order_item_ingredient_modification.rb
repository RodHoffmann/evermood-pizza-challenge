class OrderItemIngredientModification < ApplicationRecord
  belongs_to :ingredient
  belongs_to :order_item
end
