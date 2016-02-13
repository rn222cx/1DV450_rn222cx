class Api::V1::StoriesController < Api::V1::BaseController

  def index
    @stories = Story.search(params)
  end

  def show
    @story = Story.find(params[:id])

  end


end