class OrderPromotionCode < ApplicationRecord
  belongs_to :promotion_code
  belongs_to :order
  validates :order_id, :promotion_code_id, presence: true
  validates :order_id, uniqueness: { scope: :promotion_code_id }
end
