class AddGenresImageIdToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :genres_image_id, :string
  end
end
