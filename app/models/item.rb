class Item < ApplicationRecord
    has_one :category
    has_many :item_attr
    has_many :item_attributes, through: :item_attr
end
