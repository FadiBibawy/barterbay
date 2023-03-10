class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  # before_action :product_params, only: [:new]

  def index
    # raise
    # @products = Product.joins("LEFT JOIN offers ON products.id = offers.product_id OR products.id = offers.offered_product_id")
    #                    .where("offers.deal IS NULL OR offers.deal = ?", false)
    #                    .distinct
    @products = Product.where("bartered = ?", false)

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


  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :quality, :category, :address, :subcategory, photos: [])
  end
end
