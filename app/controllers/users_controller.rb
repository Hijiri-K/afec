class UsersController < ApplicationController
  # before_action :authenticate_user,{only: [:index, :show, :edit, :update, :destroy, :logout]}

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end


  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{params[:id]}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      # flash[:notice] = "ユーザー情報の編集に成功しました～～～～"
      redirect_to("/users/index")
    else
      render("users/edit")
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    # flash[:notice] = "ユーザーを削除しました～～～～"
    session[:user_id] = nil
    redirect_to("/")
  end

  def history
    @transactions = Transaction.where(user_id:current_user.id, status:"successed").order(updated_at: :desc)
  end
end
