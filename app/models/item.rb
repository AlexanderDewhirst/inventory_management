class Item < ApplicationRecord
    has_many :item_attributes
    has_many :additional_attributes, through: :item_attributes
end
