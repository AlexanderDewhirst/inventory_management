class Feature < ApplicationRecord
    has_many :item_features, dependent: :destroy
    has_many :items, through: :item_features

    belongs_to :user

    before_validation { self.title = self.title&.downcase }
    before_validation { self.value = self.value&.downcase }

    validates :title, presence: true, allow_blank: false
    validates :value, presence: true, allow_blank: false


    def to_s
        "#{title.humanize} - #{value.humanize}"
    end
end
