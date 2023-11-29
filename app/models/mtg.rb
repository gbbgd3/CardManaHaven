class Mtg < ApplicationRecord
  validates :name, presence: true
  validates :power, numericality: { only_integer: true, allow_nil: true}
  validates :toughness, numericality: { only_integer: true, allow_nil: true}

  has_one :product, as: :productable
  belongs_to :artist
  belongs_to :m_set
  has_and_belongs_to_many :card_faces, join_table: 'mcfs'
  accepts_nested_attributes_for :card_faces, allow_destroy: true
end
