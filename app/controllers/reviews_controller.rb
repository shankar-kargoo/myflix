class ReviewsController < ApplicationController
  
  before_filter :require_user

  def create
    @video = Video.find(params[:video_id])
    current_user = User.find(session[:user_id])
    review = Review.create(review_params)
    review.user = current_user
    @video.reviews << review
    if review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
