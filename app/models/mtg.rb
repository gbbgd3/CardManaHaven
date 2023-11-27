class Mtg < ApplicationRecord
  has_one :product, as: :productable
  belongs_to :artist
  belongs_to :m_set
  has_and_belongs_to_many :card_faces, join_table: 'mcfs'
end
