class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"

    post = Post.find_by(user_id: current_user.id)
    stream_for post.stream
    # stream_for current_user.group
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    user = User.find_by(id: current_user.id)
    user.group = data['group']
    user.save
    exchange = Exchange.find_by(currency: data['currency'])
    rate = exchange.rate
    puts rate
    if Post.find_by(user_id: current_user.id)
      @post=  Post.find_by(user_id: current_user.id)
      @post.update(
        content: data['message'],
        currency_have: data['currency_have'],
        currency_have_amount: data['currency_have_amount'],
        currency_want: data['currency_want'],
        # currency_want_amount: data['currency_want_amount'], レート登録方式に移行のため以下のコードに変更！！！　TODO:必要なくなったら削除
        currency_want_amount: data['currency_have_amount'].to_i * rate,
        lat: data['lat'],
        lng: data['lng'],
        location: data['airport'],
        terminal: data['terminal'],
        user_id: current_user.id,
        group: data['group'],
        stream: data['stream']
      )
    else
        @post = Post.create!(
          content: data['message'],
          currency_have: data['currency_have'],
          currency_have_amount: data['currency_have_amount'],
          currency_want: data['currency_want'],
          currency_want_amount: data['currency_want_amount'],
          lat: data['lat'],
          lng: data['lng'],
          location: data['airport'],
          terminal: data['terminal'],
          user_id: current_user.id,
          group: data['group'],
          stream: data['stream']
        )
    end
  end
  
end
