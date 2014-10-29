class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @category_videos = @category.videos
  end

end
