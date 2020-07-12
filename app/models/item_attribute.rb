class ItemAttribute < ApplicationRecord
    belongs_to :item
    belongs_to :attribute
end