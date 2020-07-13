class Item < ApplicationRecord
    has_many :item_features, dependent: :destroy
    has_many :features, through: :item_features

    belongs_to :category

    before_validation { self.name = self.name.downcase }

    def list_of_features
        output_str = ""
        features.each do |feature|
            output_str += feature.title.humanize + ": " + feature.value.humanize
            output_str += ', '
        end
        output_str.chomp(', ')
    end

end
