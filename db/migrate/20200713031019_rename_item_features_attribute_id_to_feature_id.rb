class RenameItemFeaturesAttributeIdToFeatureId < ActiveRecord::Migration[6.0]
  def change
    rename_column :item_features, :attribute_id, :feature_id
  end
end
