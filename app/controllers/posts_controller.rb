class PostsController < ApplicationController
  before_action :authenticate_user

  def index
    # @posts = Post.all.order(created_at: :desc)

    @mypost = Post.find_by(user_id: @current_user.id)
      @posts = Post.where(currency_have: @mypost.currency_want, currency_want: @mypost.currency_have)
  end

  def show
    @id = params[:id]
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new
  end

  def create
if Post.find_by(user_id: @current_user.id)
    @post = Post.find_by(user_id: @current_user.id)
    @post.content = params[:content]
    @post.currency_have = params[:currency_have]
    @post.currency_have_amount = params[:input_currency]
    @post.currency_want = params[:currency_want]
    @post.currency_want_amount = params[:currency_want_amount]
    @post.lat = params[:lat]
    @post.lng = params[:lng]
    @post.user_id = @current_user.id
else

    @post = Post.new(
      content: params[:content],
      currency_have: params[:currency_have],
      currency_have_amount: params[:input_currency],
      currency_want: params[:currency_want],
      currency_want_amount: params[:currency_want_amount],
      lat: params[:lat],
      lng: params[:lng],
      user_id: @current_user.id
    )
  end

    if @post.save
      flash[:notice] = "更新に成功しました～～～"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "編集に成功しました～～～～"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました～～～～"
    redirect_to("/posts/index")
  end


end
