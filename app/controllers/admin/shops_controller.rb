class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_shop, only: [:show, :edit, :update]

  def index
    @shop = Shop.new
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

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to admin_shops_path
    else
      @shops = Shop.all
      render :index
    end
  end

  def show
  end

  def edit
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      redirect_to admin_shops_path
    else
      render :edit
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :postal_code, :address, :telephone_number, :shop_genre_id)
  end

  def ensure_shop
    @shop = Shop.find(params[:id])
  end
end
