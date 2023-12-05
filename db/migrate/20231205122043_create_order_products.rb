class CreateOrderProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :order_products do |t|
      t.integer :product_id
      t.references :order, null: false, foreign_key: true
      t.string :product_name
      t.integer :product_price
      t.integer :product_quantity
      t.integer :product_subtotal

      t.timestamps
    end
  end
end
