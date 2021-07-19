class Public::ItemsController < ApplicationController
  def top
    @genres = Genre.only_active.includes(:items)
    @items = Item.recommended
    @item = Item.page(params[:page]).per(4).order(created_at: :desc)
    # @genreitem = Item.find(params[:id])
  end

  def index
    @genres = Genre.only_active
    if params[:genre_id]
      @genre = @genres.find(params[:genre_id])
      all_items = @genre.items
    else
      all_items = Item.where_genre_active.includes(:genre)
    end
    @items = all_items.page(params[:page]).per(5)
    @all_items_count = all_items.count
  end

  def show
    @item = Item.where_genre_active.find(params[:id])
    @genres = Genre.only_active
    @cart_item = CartItem.new
  end
end