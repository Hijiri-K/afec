class HomeController < ApplicationController
  def top
  end

  def about
  end

  def updates
    @updates = Update.all.order(created_at: :desc)
  end

  def test
    ENV["SSL_CERT_FILE"] = "app/controllers/cacert.pem"
      require 'open-uri'

      res = open('https://apilayer.net/api/live?access_key=356b689f4db8b2616a786c31a7023829&currencies=EUR,GBP,CAD,PLN,JPY,CNY,VND&source=USD&format=1')
      code, message = res.status # res.status => ["200", "OK"]

      if code == '200'
        result = ActiveSupport::JSON.decode res.read
        # resultを使ってなんやかんや処理をする
      else
        puts "OMG!! #{code} #{message}"
      end

      @result = result['quotes'] #返ってきたjsonデータをrubyの配列に変換

      @result.each do |key, value|
          if Exchange.find_by(currency: key)
            rate = Exchange.find_by(currency: key)
            rate.update(rate: value)
          else
            Exchange.create(currency: key, rate: value)
          end
      end

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

 def test3
 end

 def test4
 end

end


  # <!-- 計算 ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝-->
      # <!-- 距離の計算 -->
