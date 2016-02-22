class Api::V1::BaseController < ApplicationController
  include Pundit # For authorization
  respond_to :xml, :json

  protect_from_forgery with: :null_session
  before_action :destroy_session, :authenticate_developer

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized!
  rescue_from ActionController::ParameterMissing, with: :not_found
  rescue_from NoMethodError, with: :not_found


  def destroy_session
    request.session_options[:skip] = true
  end

  def authenticate_developer
    authenticate_or_request_with_http_token do |token, options|
      Domain.exists?(authentication_token: token)
    end
  end

  # authenticate user by users authentication token
  def authenticate_user!
    if request.headers['User-Token'].present?
      token = request.headers['User-Token']
      user = User.find_by(authentication_token: token)
      if user.nil?
        response_with('The token does not match', 401)
      else
        @current_user = user
      end

    else
      response_with('You have to be authorized', 403)
    end
  end

  def not_found
    respond_to do |format|
      format.json { render json: { error: '404, not found' }, status: 404 }
      format.xml { render xml: { error: '404, not found' }, status: 404 }
    end
  end

  def response_with (message = 'Bad request', code = 200)
    respond_to do |format|
      format.json { render json: { message: message }, status: code }
      format.xml { render xml: { message: message }, status: code }
    end
  end

  # check if offset/limit is present else set default values
  def offset_params
    offset = 0
    limit = 20
    if query_params[:offset].present?
      @offset = query_params[:offset].to_i
    end
    if query_params[:limit].present?
      @limit = query_params[:limit].to_i
    end
    @offset ||= offset
    @limit ||= limit
  end

  private

  def query_params
    params.permit(:offset, :limit)
  end

end