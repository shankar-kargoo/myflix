class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :posts, through: :video_categories
end
