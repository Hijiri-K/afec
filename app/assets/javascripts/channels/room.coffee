App.room = App.cable.subscriptions.create "RoomChannel",

  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    id = "." + data['user_id']
    console.log(id)
    $(id).remove()
    $('.posts-container').prepend data['message']



  speak: (currency_have, currency_have_amount, currency_want, currency_want_amount, message, lat, lng, airport, terminal, group, stream)　->
    @perform 'speak', currency_have: currency_have, currency_have_amount: currency_have_amount, currency_want: currency_want, currency_want_amount: currency_want_amount, message: message, lat: lat, lng: lng, airport: airport, terminal: terminal, group: group, stream: stream


  $(document).on 'click', '#exchange-submit', (event) ->
    App.room.speak $('#Currency').val(), $('#currency').val(), $('#Currency_base').val(), $('#returnYen').val(), $('#message').val(), $('.lat').val(), $('.lng').val(), $('.airport2').val(), $('.terminal2').val(), $('.airport2').val() + $('.terminal2').val() +  $('#Currency').val() + $('#Currency_base').val(), $('.airport2').val() + $('.terminal2').val() + $('#Currency_base').val() + $('#Currency').val()
