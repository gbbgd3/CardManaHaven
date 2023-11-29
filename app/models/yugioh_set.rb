class YugiohSet < ApplicationRecord
  has_many :yugioh_card_sets
  has_many :yugioh_cards, through: :yugioh_card_sets
end
