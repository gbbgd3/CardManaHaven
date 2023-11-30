class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :tax_type
      t.float :pst
      t.float :gst
      t.float :hst
      t.float :total_tax_rate

      t.timestamps
    end
  end
end
