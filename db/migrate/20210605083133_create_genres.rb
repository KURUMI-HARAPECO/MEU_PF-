class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
    	t.string :name, null: false
    	t.string :image_id
    	t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
