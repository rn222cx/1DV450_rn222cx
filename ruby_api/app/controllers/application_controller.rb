require "application_responder"

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :no_cache
  include SessionsHelper


  # Confirms an admin user
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # Confirms the correct user or admin
  def correct_user_or_admin
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user.admin? || current_user?(@user)
  end

  private
    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

  # uses on logout to prevent caching last visited page
  def no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 09 Jan 2004 00:00:00 GMT"
  end
end
