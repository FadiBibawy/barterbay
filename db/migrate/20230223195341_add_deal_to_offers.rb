class AddDealToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :deal, :boolean, default: false
  end
end
