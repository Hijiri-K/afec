class PostsController < ApplicationController
  before_action :authenticate_user

  def index
    if Post.find_by(user_id: @current_user.id)
        @mypost = Post.find_by(user_id: @current_user.id)
        @posts = Post.where(currency_have: @mypost.currency_want, currency_want: @mypost.currency_have)
    else
      @posts = Post.all.order(created_at: :desc)
    end

      if Post.find_by(user_id: @current_user.id)
    require 'json'
    @mypost = Post.find_by(user_id: @current_user.id)
    if File.exist?("tmp/#{@mypost.id}.json")
      File.open("tmp/#{@mypost.id}.json", 'r') do |f|
      offers = JSON.load(f)
      @checkoffer = offers.fetch("offer_from")
      # @offer_to = offers.fetch("offer_to")
      end
    end

    if File.exist?("tmp/accept#{@mypost.id}.json")
      File.open("tmp/accept#{@mypost.id}.json", 'r') do |f|
      offers = JSON.load(f)
      @acceptcheckoffer = offers.fetch("offer_from")
      # @acceptoffer_to = offers.fetch("offer_to")
      end
    end

    if File.exist?("tmp/map#{@mypost.id}.json")
      @mapshow = true
    end
  end
  end


  def show
    if Post.find_by(user_id: @current_user.id)
        @mypost = Post.find_by(user_id: @current_user.id)
        @posts = Post.where(currency_have: @mypost.currency_want, currency_want: @mypost.currency_have)
    else
      @posts = Post.all.order(created_at: :desc)
    end
    @id = params[:id]
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end


  def offer
    @mypost = Post.find_by(user_id: @current_user.id)
    @post = Post.find_by(id: params[:id])
    # @post.offer = @mypost.id

    # File.open("public/#{@post.id}.json", 'w') do |f|
    #   hash = {"offer_from"=> @mypost.id, "offer_to"=> @post.id}
    #   str = JSON.dump(hash, f)
    # end

    hash = {"offer_from"=> @mypost.id, "offer_to"=> @post.id}
    json = JSON.generate(hash)
    File.write("tmp/#{@post.id}.json", json)
    # if @post.save
      flash[:notice] = "Success to send offer"
      redirect_to("/posts/index")
    # else
    #   render("posts/show")
    # end
  end


  def destroyoffer
    @mypost = Post.find_by(user_id: @current_user.id)
    @mypost.offer = nil
    File.delete("tmp/#{@mypost.id}.json")
        # if @mypost.save
        #   flash[:notice] = "You decline the offer"
          redirect_to("/posts/index")
        # else
        #   # render("posts/index")
        # end
  end


  def destroyaccept
    @mypost = Post.find_by(user_id: @current_user.id)
    @mypost.offer = nil
    File.delete("tmp/accept#{@mypost.id}.json")
    File.write("tmp/map#{@mypost.id}.json", "map")
        # if @mypost.save
        #   flash[:notice] = "You decline the offer"
          redirect_to("/posts/index")
        # else
        #   # render("posts/index")
        # end
  end


  def acceptoffer
    require 'json'
    @mypost = Post.find_by(user_id: @current_user.id)
      File.open("tmp/#{@mypost.id}.json", 'r') do |f|
      offers = JSON.load(f)
      @checkoffer = offers.fetch("offer_from")
      # @offer_to = offers.fetch("offer_to")
    end

    hash = {"offer_from"=> @checkoffer, "offer_to"=> @mypost.id}
    json = JSON.generate(hash)
    File.write("tmp/accept#{@checkoffer}.json", json)
    File.write("tmp/map#{@mypost.id}.json", json)
    # if @post.save
      flash[:notice] = "You accepted offer"
      File.delete("tmp/#{@mypost.id}.json")
      redirect_to("/posts/index")
  end


  def destroymap
    @mypost = Post.find_by(user_id: @current_user.id)
    File.delete("tmp/map#{@mypost.id}.json")
    redirect_to("/posts/index")
  end


  def checkoffer
      @mypost = Post.find_by(user_id: @current_user.id)
      if File.exist?("tmp/#{@mypost.id}.json")
        redirect_to("/posts/index")
      end

      if File.exist?("tmp/accept#{@mypost.id}.json")
        redirect_to("/posts/index")
      end
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
      flash[:notice] = "Your status updated"
      redirect_to("/posts/index")
    else
      render("posts/index")
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
