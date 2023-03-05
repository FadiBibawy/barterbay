class AddAcceptedAndRefusedToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :accepted, :boolean
    add_column :offers, :refused, :boolean
  end
end
