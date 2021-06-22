class AddKomozinameToShopGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :shop_genres, :komoziname, :string
  end
end
