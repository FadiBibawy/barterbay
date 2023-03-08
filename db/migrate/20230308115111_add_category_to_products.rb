class AddCategoryToProducts < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :category, :old_category
    add_column :products, :category, :string
  end
end
