class Api::V1::StoriesController < Api::V1::BaseController

  before_action :offset_params
  before_filter :authenticate_user!, only: [:create]


  def index
    if params[:tag]
      @stories = Tag.find_by_name(params[:tag]).stories.limit(@limit).offset(@offset)
    elsif params[:location]
      @stories = Story.near(params[:location], params[:range] ||= 50).limit(@limit).offset(@offset)
    else
      @stories = Story.search(params).limit(@limit).offset(@offset)
    end

  end

  def show
    @story = Story.find(params[:id])
  end

  def create
    authorize current_user # check policies/user_policy.rb for auth rules
    respond_with current_user.stories.create(create_params)
  end

  def destroy
    authorize current_user

    @story = Story.find(params[:id])
    if @story.user_id == @current_user.id
      @story.destroy
      #respond_with nil
    else

    end
  end

  def create_params
    params.require(:story).permit(:title, :description, :all_tags, :address, :longitude, :latitude)
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