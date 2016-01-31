class StoriesController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update, :create, :destroy]
    
    def index
      @stories = Story.all
    end
    
    # def show
    #   @story = Story.find(params[:id])
    # end
    
    def new
      @story = Story.new
    end
    
    def create
      @story = current_user.stories.build(story_params)
      
      if @story.save
        flash[:success] = "Stories successfully created"
        redirect_to stories_path
      else
        render "new"
      end
    end
    
    def edit
      @story = Story.find(params[:id])
    end
    
    def update
      @story = Story.find(params[:id])
      if @story.update(story_params)
        flash[:success] = "Story successfully updated"
        redirect_to @story
      else
       render "edit"
      end
    end
    
    def destroy
      @story = Story.find(params[:id])
      @story.destroy
      flash[:success] = "Story successfully removed"
      redirect_to stories_path
    end
    
    private
    def story_params
      params.require(:story).permit(:title, :description, :all_tags)
    end
end