class Order < ApplicationRecord
  belongs_to :user
  belongs_to :status
  has_many :order_products
end
