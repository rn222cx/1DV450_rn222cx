class Api::V1::TagsController < Api::V1::BaseController


  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end


  def tag_params
    params.permit(:offset, :limit)
  end

end