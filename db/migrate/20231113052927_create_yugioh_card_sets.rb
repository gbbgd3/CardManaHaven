class CreateYugiohCardSets < ActiveRecord::Migration[7.1]
  def change
    create_table :yugioh_card_sets do |t|

      t.timestamps
    end
  end
end
