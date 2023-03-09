class ChangeProductAttributesType < ActiveRecord::Migration[7.0]
  def change
    #this column 'cateogry' already exists so we don't need it to be here
    change_column :products, :category, :string

    #this column 'subcategory' doesn't exist so we don't need to add_column not change_column
    add_column :products, :subcategory, :string
  end
end
