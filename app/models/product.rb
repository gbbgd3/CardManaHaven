class Product < ApplicationRecord
  validates :price_cents, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :sale_price_cents, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than: -1 }
  validates :product_name, presence: true
  validates :brand, presence: true
  validates :category, presence: true
  belongs_to :productable, polymorphic: true
  belongs_to :category
  has_one_attached :image
end
