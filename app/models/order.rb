class Order < ApplicationRecord
  belongs_to :discount_code
  belongs_to :order_item
end
