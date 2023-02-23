class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :quality
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
