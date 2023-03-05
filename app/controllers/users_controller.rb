class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_rating, only: [:show]
  before_action :authenticate_user!, except: [:show]

  def show
    @review = Review.new
    @availabe_products = @user.products.where(bartered: false)
    @bartered_products = @user.products.where(bartered: true)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_rating
    @user_rating = 0
    if @user.rated_reviews.size.zero?
      @user_rating = "No one rated #{@user.username}"
    else
      @user.rated_reviews.each do |review|
        @user_rating += review.rating
      end

      @user_rating /= @user.rated_reviews.size.to_f
      @user_rating = (@user_rating * 2.0).round / 2.0

    end
  end
end
