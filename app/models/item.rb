class Item < ApplicationRecord
    has_many :item_attr, dependent: :destroy
    has_many :item_attributes, through: :item_attr

    belongs_to :category

    before_validation { self.name = self.name.downcase }
end
