class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  respond_to :html, :json
  before_action :set_view_path_for_format

  def set_view_path_for_format
    if request.format == :html
      prepend_view_path 'app/views/admin'
    else
      prepend_view_path 'app/views/widget'
    end
  end

  def set_access_control
    headers['X-Frame-Options'] = HEADER_URI_CONFIG['x_frame_option_uri']
  end

  protected
  def current_user
    @current_user ||= User.last
  end
end
