class OffersController < ApplicationController
  before_action :set_product, only: [:new, :create]
  before_action :set_offer, only: [:show, :accept, :refuse, :destroy]
  before_action :set_rating1, :set_rating2, only: [:show]

  def index
    @offers = Offer.all
  end

  def show
    @chatroom = Offer.find(params[:id])
    @message = Message.new
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

  def set_rating1
    @user1_rating = 0
    if @offer.product.user.rated_reviews.size.zero?
      @user1_rating = 0
    else
      @offer.product.user.rated_reviews.each do |review|
        @user1_rating += review.rating
      end

      @user1_rating /= @offer.product.user.rated_reviews.size.to_f
      @user1_rating = (@user1_rating * 2.0).round / 2.0
    end
  end
  def set_rating2
    @user2_rating = 0
    if @offer.offered_product.user.rated_reviews.size.zero?
      @user2_rating = 0
    else
      @offer.offered_product.user.rated_reviews.each do |review|
        @user2_rating += review.rating
      end

      @user2_rating /= @offer.offered_product.user.rated_reviews.size.to_f
      @user2_rating = (@user2_rating * 2.0).round / 2.0
    end
  end


end
