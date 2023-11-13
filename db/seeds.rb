# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

Category.destroy_all
YugiohSet.destroy_all

puts 'Creating Categories...'
categories = ['Yugioh', 'Magic The Gathering', 'Card Sleeves', 'Playmats']
categories.each do |c|
  Category.create(name: c)
end

yugioh_card_path = 'db/csv/yugioh/cards.csv'
yugioh_set_path = 'db/csv/yugioh/cardsets.csv'
yugioh_cardset_path = 'db/csv/yugioh/cards_cardsets.csv'

csv = CSV.foreach(yugioh_set_path, headers: true).take(100)

puts "Creating #{csv.length} Yugioh Sets..."
csv.each do |r|
  YugiohSet.create(
    set_id: r['id'],
    set_name: r['set_name'],
    set_code: r['set_code'],
    release_date: r['tcg_date']
  )
end
puts 'Yugioh Sets seeded successfully.'
