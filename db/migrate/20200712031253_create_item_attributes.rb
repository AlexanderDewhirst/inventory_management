class CreateItemAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :item_attributes do |t|
      t.integer :item_id
      t.integer :attribute_id

      t.timestamps
    end
  end
end
