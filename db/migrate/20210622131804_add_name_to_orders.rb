class AddNameToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :name, :string
    add_column :orders, :time, :string
    add_column :orders, :minute, :string
  end
end
