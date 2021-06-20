class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
    	t.integer :shop_genre_id, null: false
    	t.string :name, null: false
    	t.string :postal_code, null: false
    	t.string :address, null: false
      t.string :telephone_number, null: false

      t.timestamps
    end
  end
end
