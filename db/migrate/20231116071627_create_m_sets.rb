class CreateMSets < ActiveRecord::Migration[7.1]
  def change
    create_table :m_sets do |t|
      t.string :name
      t.string :code
      t.date :release_date
      t.integer :card_count

      t.timestamps
    end
  end
end
