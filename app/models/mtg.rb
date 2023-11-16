class Mtg < ApplicationRecord
  belongs_to :artist
  belongs_to :set
  belongs_to :mcf
end
