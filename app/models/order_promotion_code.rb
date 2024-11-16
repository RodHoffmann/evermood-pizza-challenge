class OrderPromotionCode < ApplicationRecord
  belongs_to :promotion_code
  belongs_to :order
end
