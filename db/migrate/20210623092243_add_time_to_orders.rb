class AddTimeToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :time, :string
  end
end
