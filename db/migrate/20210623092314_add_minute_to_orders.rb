class AddMinuteToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :minute, :string
  end
end
