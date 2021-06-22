class Public::ShopsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_shop, only: [:show, :edit, :update]

  def index
    @shops = Shop.all

    @genres = ShopGenre.only_active
    if params[:shop_genre_id]
      @genre = @genres.find(params[:shop_genre_id])
      all_shops = @genre.shops
    else
      all_shops = Shop.where_genre_active.includes(:shop_genre)
    end
    @shops = all_shops.page(params[:page]).per(12)
    @all_shops_count = all_shops.count
  end

  def show
  end

  private

  def ensure_shop
    @shop = Shop.find(params[:id])
  end
end
