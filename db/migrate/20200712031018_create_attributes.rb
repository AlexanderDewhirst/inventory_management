class CreateAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :attributes do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
