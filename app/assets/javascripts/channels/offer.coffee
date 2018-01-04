App.offer = App.cable.subscriptions.create "OfferChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('.post-index-container').prepend data['offer']


  offer: (userid, message, get, give, save) ->
    @perform 'offer', user_id: userid, message: message, get: get, give: give, save: save
  #
  $(document).on 'click', '#offersubmit', (event) ->
    App.offer.offer $('#post-userid').text(), $('#postmessageshow').text(), $('#getshow').text(), $('#giveshow').text(), $('#post_offer_savemoffer').text(),
