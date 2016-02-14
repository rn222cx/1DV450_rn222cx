class Api::V1::StoriesController < Api::V1::BaseController

  before_action :offset_params

  def index
    if params[:tag]
      return @stories = Tag.find_by_name(params[:tag]).stories.limit(@limit).offset(@offset)
    end

    @stories = Story.search(params).limit(@limit).offset(@offset)
  end

  def show
    @story = Story.find(params[:id])
  end

  # check if offset/limit is present
  def offset_params
    offset = 0
    limit = 20
    if query_params[:offset].present?
      @offset = query_params[:offset].to_i
    end
    if query_params[:limit].present?
      @limit = query_params[:limit].to_i
    end
    @offset ||= offset
    @limit ||= limit
  end


  def query_params
    params.permit(:offset, :limit)
  end

end