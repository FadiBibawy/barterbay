class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :offered_product, null: false, foreign_key: { to_table: :products }

      t.timestamps
    end
  end
end
