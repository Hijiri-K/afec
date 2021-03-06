module ApplicationHelper

  def cal(mypost_lat, mypost_lng,
          mypost_currency_want, mypost_currency_have,
          mypost_currency_want_amount, mypost_currency_have_amount,
          post_lat, post_lng,
          post_currency_want, post_currency_have,
          post_currency_want_amount, post_currency_have_amount
        )

          lat1 = post_lat
          lng1 = post_lng
          lat2 = mypost_lat
          lng2 = mypost_lng

          y1 = lat1 * Math::PI / 180
          x1 = lng1 * Math::PI / 180
          y2 = lat2 * Math::PI / 180
          x2 = lng2 * Math::PI / 180
          earth_r = 6378140

          deg = Math::sin(y1) * Math::sin(y2) + Math::cos(y1) * Math::cos(y2) * Math::cos(x2 - x1)
          @distance = earth_r * (Math::atan(-deg / Math::sqrt(-deg * deg + 1)) + Math::PI / 2)
          # /1000


        # <!--交換可能な金額、手数料の浮いた分を計算するーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー  -->
         if mypost_currency_want_amount <= post_currency_have_amount
            @give = "#{mypost_currency_want}" + " " + "#{mypost_currency_want_amount.to_i}"
            @get = "#{mypost_currency_have}" + " " + "#{mypost_currency_have_amount.to_i}"
            @savem = (mypost_currency_have_amount * 0.05).round(1)
            @save ="#{mypost_currency_have}" + " " + "#{(mypost_currency_have_amount * 0.05).round(1)}"
            @savemoffer = "#{mypost_currency_want}" + " " + "#{(mypost_currency_want_amount * 0.05).round(1)}"
            @give_amount = "#{mypost_currency_want_amount.to_i}"
            @get_amount = "#{mypost_currency_have_amount.to_i}"

          elsif mypost_currency_want_amount > post_currency_have_amount
            @give = "#{post_currency_have}" + " " + "#{post_currency_have_amount.to_i}"
            @get = "#{post_currency_want}" + " " + "#{post_currency_want_amount.to_i}"
            @savem = (post_currency_want_amount * 0.05).round(1)
            @save ="#{post_currency_want}" + " " + "#{(post_currency_want_amount * 0.05).round(1)}"
            @savemoffer =  "#{post_currency_have}" + " " + "#{(post_currency_have_amount * 0.05).round(1)}"
            @give_amount = "#{post_currency_have_amount.to_i}"
            @get_amount = "#{post_currency_want_amount.to_i}"

          end

      # <!__コーヒーの数を計算（1杯５０円で計算）＝＝＝＝＝＝＝＝===＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝ __>

        if mypost_currency_have === "JPY"
          @coffee = (@savem / 300).to_i
        elsif mypost_currency_have === "USD"
          @coffee = (@savem / 3).to_i
        elsif mypost_currency_have === "EUR"
          @coffee = (@savem / 3).to_i
        end

      end

end
