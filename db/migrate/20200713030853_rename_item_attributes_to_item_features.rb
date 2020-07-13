class RenameItemAttributesToItemFeatures < ActiveRecord::Migration[6.0]
  def change
    rename_table :item_attributes, :item_features
  end
end
