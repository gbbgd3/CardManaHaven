class CardsetUniqueIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :yugioh_card_sets, [:yugioh_card_id, :yugioh_set_id], unique: true, name: 'unique_card_set_index'
  end
end
