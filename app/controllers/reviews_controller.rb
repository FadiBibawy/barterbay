class ReviewsController < ApplicationController
  before_action :set_user, only: %i[new create]

  def new
    # @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.reviewer = current_user
    @review.rated_user = @user
    @review.save
    redirect_to user_path(@user)

    if @review.save
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
