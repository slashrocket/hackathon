# Controller for Application
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, :alert => exception.message }
      format.json { render json: { success: false, info: "Unauthorized" } }
    end
  end

  # eagarload teams, to hit the db less times
  def current_user
    @current_user ||= super && User.includes(:team).find(@current_user.id)
  end
end