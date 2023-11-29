class MSet < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true
  has_many :cards
end
