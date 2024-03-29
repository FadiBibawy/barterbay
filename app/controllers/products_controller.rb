class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_rating, only: [:show]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  # before_action :product_params, only: [:new]

  def index
    # raise
    # @products = Product.joins("LEFT JOIN offers ON products.id = offers.product_id OR products.id = offers.offered_product_id")
    #                    .where("offers.deal IS NULL OR offers.deal = ?", false)
    #                    .distinct
    @products = case params[:category]
                when 'service'
                  Product.where("category= ? AND bartered= ?", 'service', false)
                when 'goods'
                  Product.where("category= ? AND bartered= ?", 'goods', false)
                else
                  Product.where("bartered = ?", false)
                end
    if params[:query].present?
      @products = @products.search(params[:query])
    end
    if @products.empty?
      flash[:notice] = "There are no products!"
    end
  end

  def show
    # @product = Product.find_by(id: params[:id])
    @markers = [
      {
        lat: @product.latitude,
        lng: @product.longitude
      }
    ]
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :form, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to current_user, status: :see_other
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :quality, :category, :address, :subcategory, photos: [])
  end

  def filter_category
    @products = @products.filter_category(params[:query])
  end


  def set_rating

    @user_rating = 0
    if @product.user.rated_reviews.size.zero?
      @user_rating = 0
    else
      @product.user.rated_reviews.each do |review|
        @user_rating += review.rating
      end

      @user_rating /= @product.user.rated_reviews.size.to_f
      @user_rating = (@user_rating * 2.0).round / 2.0
    end
  end
end
