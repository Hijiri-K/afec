class UsersController < ApplicationController
  before_action :authenticate_user,{only: [:index, :show, :edit, :update, :destroy, :logout]}

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "user_image_default.jpg",
      password: params[:password]
    )
    if @user.save
      flash[:notice] = "Success to Signup"
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      render("home/top")
    end
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
      flash[:notice] = "ユーザー情報の編集に成功しました～～～～"
      redirect_to("/users/index")
    else
      render("users/edit")
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "ユーザーを削除しました～～～～"
    session[:user_id] = nil
    redirect_to("/")
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(
      email: params[:email],
      password: params[:password]
    )
    if @user
      flash[:notice] = "Success to Login"
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      @error_message = "E-mail or Password is worng"
      render("home/top")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "logouted"
    redirect_to("/")
  end

end
