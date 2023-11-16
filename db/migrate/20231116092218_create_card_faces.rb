class CreateCardFaces < ActiveRecord::Migration[7.1]
  def change
    create_table :card_faces do |t|
      t.string :name
      t.string :mana
      t.string :type_line
      t.string :oracle_text
      t.integer :power
      t.integer :toughness
      t.string :image
      t.string :flavour_text

      t.timestamps
    end
  end
end
