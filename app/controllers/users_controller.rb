class UsersController < ApplicationController

  before_action :set_user, only: [:show]
  before_action :set_rating, only: [:show]
  def show
    @review = Review.new
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_rating
    @user_rating = 0
    unless @user.rated_reviews.size.zero?

      @user.rated_reviews.each do |review|
        @user_rating += review.rating
      end

      @user_rating /= @user.rated_reviews.size.to_f
      @user_rating = (@user_rating * 2.0).round / 2.0
    end
  end

end
