class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :shop
  has_many :order_details
  has_many :items, through: :order_details


  validates :payment_method, presence: true
  validates :time, presence: true
  validates :minute, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }

  def get_shipping_informations_from(resource)
    class_name = resource.class.name
    if class_name == 'Customer' # resource: Customer
      self.postal_code = resource.postal_code
      self.destination = resource.address
      self.name = resource.full_name
    elsif class_name == 'Address' # resource: Address
      self.postal_code = resource.postal_code
      self.destination = resource.destination
      self.name = resource.name
    end
  end

  def create_order_details(customer)
    unless order_details.first
      cart_items = customer.cart_items.includes(:item)
      cart_items.each do |cart_item|
        item = cart_item.item
        OrderDetail.create!(
          shop_id: id,
          order_id: id,
          item_id: item.id,
          price: item.with_tax_price,
          amount: cart_item.amount
        )
      end
      cart_items.destroy_all
    end
  end

  def are_all_details_completed?
    (order_details.completed.count == order_details.count) ? true : false
  end
end
