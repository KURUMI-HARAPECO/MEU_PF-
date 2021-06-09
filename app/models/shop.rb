class Shop < ApplicationRecord
  has_many :order_details

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
end
