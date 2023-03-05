class OffersController < ApplicationController
  before_action :set_product, only: [:new, :create]
  before_action :set_offer, only: [:show, :accept, :refuse]

  def index
    @offers = Offer.all
  end

  def show
  end

  def new
    @offer = Offer.new
  end

  def create
    # @offered_product = Product.find(offer_params)
    @offer = Offer.new(offered_product: Product.find(offer_params[:offered_product].to_i))
    @offer.product = @product
    @offer.user = current_user
    # @offer.offered_product = @offered_product
    if @offer.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    @offer.accept_or_refuse('accept')
    redirect_to @offer.product, notice: 'Offer accepted.'
  end

  def refuse
    @offer.accept_or_refuse('refuse')
    redirect_to @offer.product, notice: 'Offer refused.'
  end

  private

  def offer_params
    params.require(:offer).permit(:offered_product)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
