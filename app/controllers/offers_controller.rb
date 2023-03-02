class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @product = Product.find(params[:product_id])
    @offered_product = Product.find(params[:offered_product_id])
    @offer = Offer.new
    @offer.product = @product
    @offer.offered_product = @offered_product
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:offered_product_id, :product_id, :user_id [])
  end
end
