class CreateYugiohCards < ActiveRecord::Migration[7.1]
  def change
    create_table :yugioh_cards do |t|
      t.integer :card_id
      t.string :name
      t.string :card_type
      t.integer :level
      t.string :attribute_of_card
      t.string :archetype
      t.text :description_of_card
      t.integer :atk
      t.integer :def
      t.string :image

      t.timestamps
    end
  end
end
