class YugiohCard < ApplicationRecord
  has_one :product, as: :productable
  has_many :yugioh_card_sets
  has_many :yugioh_sets, through: :yugioh_card_sets
end
