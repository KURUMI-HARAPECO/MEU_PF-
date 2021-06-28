class ShopGenre < ApplicationRecord
  has_many :shops

  scope :only_active, -> { where(is_active: true) }

  validates :name, presence: true
end
