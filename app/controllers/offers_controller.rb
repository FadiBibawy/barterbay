class OffersController < ApplicationController

  before_action :set_product, only: [:new, :create]
  before_action :set_offer, only: [:show, :accept, :refuse, :destroy]

  def index
    @offers = Offer.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def new
    @offer = Offer.new
    @products = current_user.products.where('bartered = ?', false)
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

  def destroy
    @offer.destroy
    redirect_to current_user
    # respond_to do |format|
    #   format.html {}
    #   format.turbo_stream { render turbo_stream: turbo_stream.remove(@offer) }
    #   format.json { head :no_content }
    # end

  end

  def accept

    @offer.accept_or_refuse('accept')
    @offer.product.bartered = true
    @offer.offered_product.bartered = true
    @offer.product.save
    @offer.offered_product.save

    if @offer.save(validate: false)
      redirect_to current_user, notice: 'Offer accepted.'
    else
      # error message
      render :show, status: :unprocessable_entity
    end
  end

  def refuse
    @offer.accept_or_refuse('refuse')
    if @offer.save(validate: false)
      redirect_to current_user, notice: 'Offer refused.'
    else
      render :show, status: :unprocessable_entity
    end
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
