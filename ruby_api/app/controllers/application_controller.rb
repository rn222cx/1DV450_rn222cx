require "application_responder"

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper


  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms the correct user or admin
  def admin_or_author
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user.admin? || current_user?(@user)
  end
  
  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
