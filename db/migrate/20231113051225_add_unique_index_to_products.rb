class AddUniqueIndexToProducts < ActiveRecord::Migration[7.1]
  def change
    add_index :products, [:productable_type, :productable_id], unique: true, name: 'product_id'
  end
end
