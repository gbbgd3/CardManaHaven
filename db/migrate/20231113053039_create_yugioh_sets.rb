class CreateYugiohSets < ActiveRecord::Migration[7.1]
  def change
    create_table :yugioh_sets do |t|
      t.integer :set_id
      t.string :set_name
      t.string :set_code
      t.date :release_date
      
      t.timestamps
    end
  end
end
