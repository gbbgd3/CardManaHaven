class CreateMtgs < ActiveRecord::Migration[7.1]
  def change
    create_table :mtgs do |t|
      t.string :name
      t.string :mana
      t.string :type_line
      t.string :oracle_text
      t.string :flavour_text
      t.references :artist, null: false, foreign_key: true
      t.string :layout
      t.integer :power
      t.string :toughness
      t.references :set, null: false, foreign_key: true
      t.string :image
      t.references :mcf, null: false, foreign_key: true

      t.timestamps
    end
  end
end
