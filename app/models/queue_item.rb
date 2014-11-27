class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_numericality_of :position, {only_integer: true}

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

  def rating= (new_rating)
    review = Review.where(user_id: user.id, video_id: video.id).first
    if review
      review.update_columns(rating: new_rating)
    else
      review = Review.new(user: user, video: video, rating: new_rating)
      review.save(validate: false)
    end

  end


  def category
    self.video.categories.first
  end

end
