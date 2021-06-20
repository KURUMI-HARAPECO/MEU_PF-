class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_shop, only: [:show, :edit, :update]

  def index
    @shop = Shop.new
    @shops = Shop.all
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
    if @shop.update(shop_params)
      unless @shop.is_active
        @shop.items.update_all(is_active: false)
      end
      redirect_to admin_shops_path
    else
      render :edit
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :postal_code, :address, :telephone_number)
  end

  def ensure_shop
    @shop = Shop.find(params[:id])
  end
end
