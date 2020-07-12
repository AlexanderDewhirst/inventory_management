class AddTitleToAttributes < ActiveRecord::Migration[6.0]
  def change
    add_column :attributes, :title, :string
  end
end
