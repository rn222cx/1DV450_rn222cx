class Api::V1::UsersController < Api::V1::BaseController

  #respond_to :json, :xml
  #before_filter :authenticate_user!, only: [:show]

  def index
    @users = User.all

      # respond_to do |format|
      #   format.json { render }
      #   format.xml { render xml: @users }
      # end
    #respond_with users.order(:created_at => :desc), :except => :password_digest
  end


  def show
    @user = User.find_by(params[:username])
    #authorize user # check policies/user_policy.rb for auth rules


  end


  # def create
      #   respond_with User.create(params[:users])
      # end
      #
      # def update
      #   respond_with User.update(params[:id], params[:users])
      # end
      #
      # def destroy
      #   respond_with User.destroy(params[:id])
      # end

      # private
      #
      # def user_params
      #   params.require(:user).permit(:email, :password, :password_confirmation)
      # end

end