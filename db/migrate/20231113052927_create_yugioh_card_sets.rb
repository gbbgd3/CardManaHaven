class CreateYugiohCardSets < ActiveRecord::Migration[7.1]
  def change
    create_table :yugioh_card_sets do |t|
      t.references :yugioh_card, foreign_key: true
      t.references :yugioh_set, foreign_key: true
      t.string :set_code
      t.string :set_rarity

      t.timestamps
    end
  end
end
