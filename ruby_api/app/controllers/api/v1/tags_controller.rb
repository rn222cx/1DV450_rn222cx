class Api::V1::TagsController < Api::V1::BaseController

  def index
    @tags = Tag.all.limit(@limit).offset(@offset)
  end

  def show
    @tag = Tag.find(params[:id])
  end
end