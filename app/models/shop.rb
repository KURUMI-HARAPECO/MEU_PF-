class Shop < ApplicationRecord
  belongs_to :shop_genre
  has_many :orders


  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true


  scope :where_genre_active, -> { joins(:shop_genre).where(shop_genres: { is_active: true }) }

  def self.recommended
    recommends = []
    active_genres = ShopGenre.only_active.includes(:shops)
    active_genres.each do |genre|
      shop = shop_genre.shops.last
      recommends << shop if shop
    end
    recommends
  end
end
