class Api::V1::StoriesController < Api::V1::BaseController

  before_action :offset_params
  before_action :authenticate_user!, only: [:create, :destroy, :update]

  def index
    if params[:tag] # Find by tags
      @stories = Tag.find_by_name(params[:tag]).stories.limit(@limit).offset(@offset)
    elsif params[:location] # Find by location
      @stories = Story.near(params[:location], params[:range] ||= 50).limit(@limit).offset(@offset)
    else # Find by search string by title and description. If search is empty it renders all
      @stories = Story.search(params).limit(@limit).offset(@offset)
    end
  end

  def show
    @story = Story.find(params[:id])
  end

  def create
    authorize current_user # check policies/user_policy.rb for auth rules

    story = Story.new(story_params.except(:tags))
    story.user_id = current_user.id

    # if tags are present
    if story_params[:tags].present?
      tags_params = story_params[:tags]

      tags_params.each do |tag|
        # If tag exists then use existing tag name
        if Tag.exists?(tag)
          story.tags << Tag.find_by_name(tag["name"])
        else
          story.tags << Tag.new(tag)
        end
      end
    end

    if story.save
      response_with('Story successfully created', 200)
    else
      response_with('Sorry, could not create story', 400)
    end
  end

  def update
    story = Story.find(params[:id])
    authorize story # check policies/story_policy.rb for auth rules

    if story.update(story_params)
      response_with('Story successfully updated', 200)
    else
      response_with('Sorry could not update story', 400)
    end
  end

  def destroy
    story = Story.find(params[:id])
    authorize story # check policies/story_policy.rb for auth rules

    if story.destroy
      response_with('Story successfully removed', 200)
    else
      response_with('Could not remove story', 400)
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :description, :address, :longitude, :latitude, tags: [ :name ])
  end

end