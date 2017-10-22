class ApplicationController < ActionController::Base
  protect_from_forgery :except => [:offer]#with: :exception

  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])

  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "Please login again"
      redirect_to("/")
    end
  end

  def session_clear
    session[:user_id] = nil
  end


end
