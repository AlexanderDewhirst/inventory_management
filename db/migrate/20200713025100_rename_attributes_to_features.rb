class RenameAttributesToFeatures < ActiveRecord::Migration[6.0]
  def change
    rename_table :attributes, :features
  end
end
