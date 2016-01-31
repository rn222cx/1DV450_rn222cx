class Api::V1::BaseController < ApplicationController
  include Pundit # For authorization
  # include ActiveHashRelation # Dont use yet
  respond_to :json, :xml

  protect_from_forgery with: :null_session

  before_action :destroy_session, :default_format_json
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    api_error(status: 404, errors: 'Not found')
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    # Find user by email
    user_email = options.blank?? nil : options[:email]
    user = user_email && User.find_by(email: user_email)
    # Get users api key
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

  def default_format_json
    if (request.headers["HTTP_ACCEPT"].nil? && params[:format].nil?) ||
        (request.headers["HTTP_ACCEPT"] != "application/xml" && params[:format] != "xml")
      request.format = "json"
    end
  end
end