class Attribute < ApplicationRecord
    has_many :item_attributes, dependent: :destroy
    has_many :items, through: :item_attributes

    belongs_to :user

    before_validation { self.title = self.title.downcase }
    before_validation { self.value = self.value.downcase }
end
