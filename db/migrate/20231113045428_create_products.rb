class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.integer :price_cents
      t.integer :sale_price_cents
      t.text :product_detail
      t.string :image_url
      t.integer :stock
      t.string :product_name
      t.string :brand
      t.references :productable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
