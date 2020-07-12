class Attribute < ApplicationRecord
    has_many :item_attributes
    has_many :items, through: :item_attributes
end
