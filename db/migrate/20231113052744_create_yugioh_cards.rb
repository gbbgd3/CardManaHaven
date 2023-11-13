class CreateYugiohCards < ActiveRecord::Migration[7.1]
  def change
    create_table :yugioh_cards do |t|

      t.timestamps
    end
  end
end
