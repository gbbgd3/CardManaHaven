class YugiohCard < ApplicationRecord
  has_one :product, as: :productable
  has_many :yugioh_card_sets, dependent: :destroy
  has_many :yugioh_sets, through: :yugioh_card_sets
  validates :name, presence: true
  validates :card_type, presence: true
  # validates :image, presence: true
  accepts_nested_attributes_for :yugioh_card_sets, allow_destroy: true
end
