class CreateYugiohCards < ActiveRecord::Migration[7.1]
  def change
    create_table :yugioh_cards do |t|
      t.string :name
      t.string :card_type
      t.integer :atk
      t.integer :def
      t.integer :level
      t.string :attribute
      t.string :archetype
      t.string :image
      t.string :card_id
      t.text :description

      t.timestamps
    end
  end
end
