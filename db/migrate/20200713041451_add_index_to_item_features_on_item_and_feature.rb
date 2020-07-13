class AddIndexToItemFeaturesOnItemAndFeature < ActiveRecord::Migration[6.0]
  def change
    add_index :item_features, [:item_id, :feature_id], unique: true
  end
end
