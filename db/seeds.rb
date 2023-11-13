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

YugiohCardSet.destroy_all
Category.destroy_all
YugiohCard.destroy_all
YugiohSet.destroy_all

puts 'Creating Categories...'
categories = ['Yugioh', 'Magic The Gathering', 'Card Sleeves', 'Playmats']
categories.each do |c|
  Category.create(name: c)
end

yugioh_card_path    = 'db/csv/yugioh/cards.csv'
yugioh_cardset_path = 'db/csv/yugioh/cards_cardsets.csv'
yugioh_set_path     = 'db/csv/yugioh/cardsets.csv'

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

puts 'Creating Yugioh Cards Table...'
card_data = CSV.foreach(yugioh_card_path, headers: true).take(1000)
card_data.each do |row|
  YugiohCard.create(
    name: row['name'],
    card_type: row['type'],
    atk: row['atk'],
    def: row['def'],
    level: row['level'],
    attribute_of_card: row['attribute'],
    archetype: row['archetype'],
    image: row['img'],
    card_id: row['card_id'.to_i],
    description_of_card: row['desc']
  )
end
puts 'Finished Seeding Yugioh Cards Table.'

puts 'Creating Joiner Table...'
csv = CSV.foreach(yugioh_cardset_path, headers: true).take(5000)
csv.each do |row|
  card = YugiohCard.find_by(card_id: row['card_id'].to_i)
  set = YugiohSet.find_by(set_id: row['set_id'].to_i)

  next unless card.present? && set.present?
    cardset = YugiohCardSet.create(
      yugioh_card_id: card.id,
      yugioh_set_id: set.id,
      set_rarity: row['set_rarity'],
      set_code: row['set_rarity_code']
    )
end
puts 'Finished Seeding joiner table.'
