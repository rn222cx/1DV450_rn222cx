class Api::V1::UsersController < Api::V1::BaseController

  def index
    @users = User.all.order(:created_at => :desc)
  end

  def show
    @user = User.find_by_username(params[:id].downcase)
  end

end