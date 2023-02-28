class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.references :reviewer, null: false, foreign_key: { to_table: :users }
      t.references :rated_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
