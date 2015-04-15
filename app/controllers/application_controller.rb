class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :require_login

  def require_login
    return nil if logged_in?
    flash[:alert] = 'You must be logged in to access this section'
    redirect_to :root
  end
end
