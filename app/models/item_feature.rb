class ItemFeature < ApplicationRecord
    belongs_to :item
    belongs_to :feature
end