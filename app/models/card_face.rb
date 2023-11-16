class CardFace < ApplicationRecord
    has_and_belongs_to_many :mtgs, join_table: 'mcfs'
end
