class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  respond_to :html, :json
  before_action :require_authentication

  def require_authentication
    unless current_user
      flash[:error] = 'You must be logged in to access this section.'
      redirect_to log_in_url
    end
  end

  protected
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
