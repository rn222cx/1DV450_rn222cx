class Api::V1::BaseController < ApplicationController
  include ActionController::ImplicitRender # Render RABL
  include Pundit # For authorization

  respond_to :xml, :json

  protect_from_forgery with: :null_session
  before_action :destroy_session#, :default_format_json

  # rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # rescue_from Pundit::NotAuthorizedError, with: :unauthorized!
  # rescue_from ActionController::ParameterMissing, with: :not_found
  # rescue_from NoMethodError, with: :not_found



  def destroy_session
    request.session_options[:skip] = true
  end

  def authenticate_user!
    # Parses Authorization header which holds both token and email.
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    return unauthorized! if token.nil? || options.nil?

    # Find user by email from header
    user = User.find_by(email: options[:email])
    # Check if email or token exist for current user
    # return unauthenticated! if user.nil? || user.domains.find_by(authentication_token: token).nil?

    # validate email and token
    if user && ActiveSupport::SecurityUtils.secure_compare(user.domains.find_by(authentication_token: token).authentication_token, token)
      @current_user = user
    else
      unauthenticated!
    end

  end

  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render json: { error: '401, bad credentials' }, status: 401
  end

  def not_found
    respond_to do |format|
      format.json { render json: { error: '404, not found' }, status: 404 }
      format.xml { render xml: { error: '404, not found' }, status: 404 }
    end
  end

  def unauthorized!
    render json: { error: '403, not authorized' }, status: 403
  end

  # def default_format_json
  #   if (request.headers["HTTP_ACCEPT"].nil? && params[:format].nil?) ||
  #       (request.headers["HTTP_ACCEPT"] != "application/xml" && params[:format] != "xml")
  #     request.format = "json"
  #   end
  # end


end