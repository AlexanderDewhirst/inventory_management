class AddConstraintsToAmountInItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :amount, :integer, null: false, default: 0
  end
end
