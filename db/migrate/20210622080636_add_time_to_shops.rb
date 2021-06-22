class AddTimeToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :time, :string
  end
end
