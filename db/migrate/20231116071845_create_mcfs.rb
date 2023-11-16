class CreateMcfs < ActiveRecord::Migration[7.1]
  def change
    create_table :mcfs do |t|
      t.references :mtg, null: false, foreign_key: true
      t.references :cf, null: false, foreign_key: true

      t.timestamps
    end
  end
end
