class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.string :stripe_id
      t.datetime :order_complete_date
      t.integer :subtotal
      t.integer :total
      t.integer :tax_rate
      t.string :tax_display

      t.timestamps
    end
  end
end
