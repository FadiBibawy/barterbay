class ChangeProductAttributesType < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :category, :string
    change_column :products, :subcategory, :string
  end
end
