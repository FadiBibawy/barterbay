class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @products = Product.joins("LEFT JOIN offers ON products.id = offers.product_id OR products.id = offers.offered_product_id")
                .where("offers.deal IS NULL OR offers.deal = ?", false)
  end
end
