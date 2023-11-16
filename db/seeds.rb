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
require 'net/http'
require 'json'

Product.destroy_all
Category.destroy_all
YugiohCardSet.destroy_all
YugiohCard.destroy_all
YugiohSet.destroy_all
Mtg.destroy_all
MSet.destroy_all
Mcf.destroy_all
CardFace.destroy_all
Artist.destroy_all

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
    image: row['image_url'],
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

  existing_record = YugiohCardSet.find_by(yugioh_card_id: card.id, yugioh_set_id: set.id)
  next if existing_record.present?

  cardset = YugiohCardSet.create(
    yugioh_card_id: card.id,
    yugioh_set_id: set.id,
    set_rarity: row['set_rarity'],
    set_code: row['set_rarity_code']
  )
end
puts 'Finished Seeding joiner table.'

puts 'Updating joiner table and reprints'
all = YugiohCard.all
all.each do |card|
  if card.yugioh_card_sets.present?
    card.yugioh_card_sets.each do |cs|
      new_card = YugiohCard.create(
        name: cs.yugioh_card.name,
        card_type: cs.yugioh_card.card_type,
        level: cs.yugioh_card.level,
        attribute_of_card: cs.yugioh_card.attribute_of_card,
        archetype: cs.yugioh_card.archetype,
        description_of_card: cs.yugioh_card.description_of_card,
        atk: cs.yugioh_card.atk,
        def: cs.yugioh_card.def,
        image: cs.yugioh_card.image
      )

      new_card_set = YugiohCardSet.create(
        yugioh_card_id: new_card.id,
        yugioh_set_id: cs.yugioh_set_id,
        set_rarity: cs.set_rarity,
        set_code: cs.set_code
      )
    end
  else
    new_card = YugiohCard.create(
      name: card.name,
      card_type: card.card_type,
      level: card.level,
      attribute_of_card: card.attribute_of_card,
      archetype: card.archetype,
      description_of_card: card.description_of_card,
      atk: card.atk,
      def: card.def,
      image: card.image
    )
  end
end

puts 'Deleting old card data'
YugiohCardSet.where(yugioh_card_id: YugiohCard.where.not(card_id: nil)).destroy_all
YugiohCard.where.not(card_id: nil).destroy_all
puts 'Done.'

private def get_y_card_price(rarity)
  case rarity
  when 'Common'
    rand(1..7)
  when 'Rare'
    rand(10..33)
  when 'Super Rare'
    rand(20..70)
  when 'Ultra Rare'
    rand(33..400)
  else
    rand(300..150_000)
  end
end

private def calculate_sale_price(price)
  return price unless rand <= 0.2

  (price * 0.75).round
end

puts 'Creating Yugioh Products'
all_y_cards = YugiohCard.limit(50)
all_y_cards.each do |card|
  price = if card.yugioh_card_sets.any?
            get_y_card_price(card.yugioh_card_sets.first.set_rarity)
          else
            get_y_card_price('Common')
          end
  category = Category.find_or_create_by(name: 'Yugioh')
  Product.create!(
    category:,
    price_cents: price,
    sale_price_cents: calculate_sale_price(price),
    image_url: card.image,
    stock: rand(0..100),
    product_name: card.name,
    brand: 'Konami',
    productable: card
  )
end
puts 'Done Yugioh Card Products'

def fetch_data(url)
  uri = URI(url)
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  else
    puts "Error fetching data: #{uri} \n ---------- \n #{response.code} - #{response.message}"
    nil
  end
end

puts 'Seeding Magic Sets'
sets_base = fetch_data('https://api.scryfall.com/sets')
card_urls = []
n = 0

sets_base['data'].each do |set|
  unless n >= 50 && n <= 55
    card_urls.push(set['search_uri'])
    MSet.create(
      name: set['name'],
      code: set['code'],
      release_date: set['released_at'],
      card_count: set['card_count']
    )
  end

  n += 1

  break if n > 55
end

def generate_price_in_cents
  probabilities = {
    over_50: 1,
    twenty_to_50: 4,
    ten_to_20: 5,
    four_to_10: 25,
    one_to_4: 55,
    under_one: 10
  }

  total_probability = probabilities.values.sum

  return 4 if total_probability.zero?

  random_number = rand(1..total_probability)

  cumulative_probability = 0
  probabilities.each do |price_range, probability|
    cumulative_probability += probability
    return convert_price_range_to_cents(price_range).round if random_number <= cumulative_probability
  end
  return 4
end


def convert_price_range_to_cents(price_range)
  case price_range
  when :over_50
    rand(5000..10000)
  when :twenty_to_50
    rand(2000..5000)
  when :ten_to_20
    rand(1000..2000)
  when :four_to_10
    rand(400..1000)
  when :one_to_4
    rand(100..400)
  when :under_one
    rand(1..100)
  else
    rand(1..1000)
  end
end

begin
  puts 'Creating and seeding Cards'
  card_urls.each do |url|
    cards = fetch_data(url)
    cards['data'].each do |card|
      mtg_set = MSet.find_by(name: card['set_name'])
      artist = Artist.find_or_create_by(name: card['artist'])
      image = card.dig('image_uris', 'png')
      card_face_obj = []
      price = card['prices'].values.compact.max
      price = (price.to_f * 100).round unless price.nil?
      price = generate_price_in_cents if price.nil?
      next if mtg_set.nil?

      if card.key?('card_faces')
        card_faces = card['card_faces']
        card_faces.each do |cf|
          cf_image = cf.dig('image_uris', 'png')
          cf_record = CardFace.create(
            name: card['name'],
            mana: card['mana_cost'],
            type_line: card['type_line'],
            oracle_text: card['oracle_text'],
            flavour_text: card['flavor_text'],
            power: card['power']&.to_i,
            toughness: card['toughness']&.to_i,
            image: cf_image
          )
          card_face_obj.push(cf_record)
        end
      end

      mtg_card = Mtg.create(
        name: card['name'],
        mana: card['mana_cost'],
        type_line: card['type_line'],
        oracle_text: card['oracle_text'],
        flavour_text: card['flavor_text'],
        artist:,
        layout: card['layout'],
        power: card['power']&.to_i,
        toughness: card['toughness']&.to_i,
        m_set: mtg_set,
        image:
      )

        category = Category.find_or_create_by(name: 'Magic The Gathering')
        Product.create!(
          category:,
          price_cents: price,
          sale_price_cents: calculate_sale_price(price),
          image_url: image,
          stock: rand(0..100),
          product_name: card['name'],
          brand: 'Wizards of the Coast',
          productable: mtg_card
        )

      next if card_face_obj.nil?

      card_face_obj.each do |cf|
        mtg_card.card_faces << cf
      end
    end
    sleep(0.1)
  end
rescue StandardError => e
  puts "An error occurred: #{e.message}"
  puts e.backtrace.join("\n")
end
