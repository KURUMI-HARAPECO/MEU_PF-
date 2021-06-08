class Public::ItemsController < ApplicationController
  # def top
  #   @genres = Genre.only_active.includes(:items)
  #   @items = Item.recommended
  # end

  # def index
  #   @genres = Genre.only_active
  #   if params[:genre_id]
  #     @genre = @genres.find(params[:genre_id])
  #     all_items = @genre.items
  #   else
  #     all_items = Item.where_genre_active.includes(:genre)
  #   end
  #   @items = all_items.page(params[:page]).per(12)
  #   @all_items_count = all_items.count
  # end

  # def show
  #   @item = Item.where_genre_active.find(params[:id])
  #   @genres = Genre.only_active
  #   @cart_item = CartItem.new
  # end

  def top
    # @genres = Genre.only_active.includes(:items)
    # @items = Item.recommended
  end

  def index
    @item = Item.all
    @items = Item.page(params[:page]).per(10)
    @customer = current_customer
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
