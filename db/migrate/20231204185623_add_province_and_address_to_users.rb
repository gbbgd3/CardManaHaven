class AddProvinceAndAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :province, foreign_key: true
    add_column :users, :address, :string
  end
end
