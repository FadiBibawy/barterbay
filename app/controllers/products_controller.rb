class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  # before_action :product_params, only: [:new]

  def index
    @products = Product.all
  end

  def show

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
end

private

def set_product
  @product = Product.find(params[:id])
end

def product_params
  params.require(:product).permit(:title, :description, :category, :quality, photos: [])
end
