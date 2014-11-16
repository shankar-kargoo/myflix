class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories
  has_many :reviews
  has_many :queue_items
  
  validates :title, presence: true
  validates :description, presence: true
  
  
  def self.search_by_title(search_text)
    return [] if search_text.blank?
    Video.where("title LIKE ?", "%#{search_text}%").order("created_at DESC")
  end

end
