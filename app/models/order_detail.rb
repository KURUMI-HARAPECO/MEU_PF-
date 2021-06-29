class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :shop

  validates :item_id, uniqueness: { scope: :order_id }
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :amount, presence: true, :numericality => { :greater_than_or_equal_to => 1 }

  def subtotal
    price * amount
  end
end
