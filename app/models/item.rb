class Item < ApplicationRecord
    has_many :item_features, dependent: :destroy
    has_many :features, through: :item_features

    belongs_to :category

    before_validation { self.name = self.name.downcase }
end
