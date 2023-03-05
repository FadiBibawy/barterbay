class AddBarteredToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :bartered, :boolean, default: false
  end
end
