class Admin::ShopGenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_genre, only: [:show, :edit, :update]

  def index
    @genre = ShopGenre.new
    @genres = ShopGenre.all
  end

  def create
    @genre = ShopGenre.new(genre_params)
    if @genre.save
      redirect_to admin_shop_genres_path
    else
      @genres = ShopGenre.all
      render :index
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      unless @genre.is_active
        @genre.shops.update_all(is_active: false)
      end
      redirect_to admin_shop_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:shop_genre).permit(:name, :komoziname, :is_active)
  end

  def ensure_genre
    @genre = ShopGenre.find(params[:id])
  end
end
