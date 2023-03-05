class AddOfferRefToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :offer, null: false, foreign_key: true
  end
end
