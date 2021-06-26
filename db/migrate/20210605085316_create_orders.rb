class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :shop_id
    	t.integer :customer_id
			t.integer :payment_method, null: false, default: 0
			t.integer :total_payment
			t.integer :status, null: false, default: 0
			t.string :minute
			t.string :time
      t.timestamps
    end
  end
end
