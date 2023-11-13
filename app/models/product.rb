class Product < ApplicationRecord
    belongs_to :productable, polymorphic: true
    belongs_to :category
end
