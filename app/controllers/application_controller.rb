class ApplicationController < ActionController::Base
  protect_from_forgery :except => [:offer]#with: :exception
  before_action :authenticate_user!, except: :top

  before_action :set_current_user, only: :index
  before_action :set_mypost
  before_action :configure_permitted_parameters, if: :devise_controller?

# deviseのオーバーライド
  def after_sign_in_path_for(resource)
    posts_index_path
  end

  def after_sign_out_path_for(resource)
    home_top_path
  end

# ここまで
  def set_current_user
  #   current_user = User.find_by(id: session[:user_id])
    session['user_id'] = current_user.id
  end


  def set_mypost
    if  User.find_by(id: session[:user_id]) && Post.find_by(user_id: current_user.id)
        @mypost = Post.find_by(user_id: current_user.id)
    end
  end


  # def authenticate_user
  #   if current_user == nil
  #     flash[:notice] = "Please login again"
  #     redirect_to("/")
  #   end
  # end

  def session_clear
    session[:user_id] = nil
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end


end
