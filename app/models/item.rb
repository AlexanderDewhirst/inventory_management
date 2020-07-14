class Item < ApplicationRecord
    has_many :item_features, dependent: :destroy
    has_many :features, through: :item_features

    belongs_to :category
    belongs_to :user

    before_validation { self.name = self.name.downcase }

    def list_of_features
        output_str = ""
        features.each do |feature|
            output_str += feature.title.humanize + ": " + feature.value.humanize
            output_str += ', '
        end
        output_str.chomp(', ')
    end

    def duplicate
        self.dup
    end

    # For scalability and best coding practices, if this were a larger project then I would use a decorator or view_model to provide this method.
    def selected_features
        ItemFeature.where(item_id: self.id, feature_id: Feature.all.collect(&:id)).collect(&:feature_id)
    end

    def price_in_dollars
        self.price / 100.00
    end

end
