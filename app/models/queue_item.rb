class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  def video_title
    self.video.title
  end
  
  def category_name
    self.video.categories.first.name
  end

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def category
    self.video.categories.first
  end

end
