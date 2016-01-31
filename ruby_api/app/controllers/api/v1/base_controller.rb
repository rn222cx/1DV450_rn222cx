class Api::V1::BaseController < ApplicationController
  include Pundit # For authorization
  include ActiveHashRelation # Dont use yet

  protect_from_forgery with: :null_session

  before_action :destroy_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    api_error(status: 404, errors: 'Not found')
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    # Check if email is the same in users table
    user_email = options.blank?? nil : options[:email]
    user = user_email && User.find_by(email: user_email)
    # Get key from users domain table
    domain_key = user.domains.where(authentication_token: token).first.authentication_token

    if user && ActiveSupport::SecurityUtils.secure_compare(domain_key, token)
      @current_user = user
    else
      unauthenticated!
    end
  end

  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render json: { error: 'Bad credentials' }, status: 401
  end
end