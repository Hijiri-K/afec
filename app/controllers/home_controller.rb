class HomeController < ApplicationController
  def top
  end

  def about
  end

  def updates
    @updates = Update.all.order(created_at: :desc)
  end

  def test
  end


  def test2
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
end


  # <!-- 計算 ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝-->
      # <!-- 距離の計算 -->
