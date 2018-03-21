App.accept = App.cable.subscriptions.create "AcceptChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
      $('.post-index-container').append data['accept']

  accept: (userid, message, get, give, save, id, give_currency, receive_currency, give_currency_amount, receive_currency_amount)->
    @perform 'accept', user_id: userid, message: message, get: get, give: give, save: save, id: id, give_currency: give_currency, receive_currency: receive_currency, give_currency_amount: give_currency_amount, receive_currency_amount: receive_currency_amount
    console.log(userid, message, get, give, save, id, give_currency, receive_currency, give_currency_amount, receive_currency_amount)

  $(document).on 'click', '.offer-accept', (event) ->
    console.log("accept");
    App.accept.accept $(this).parents('.slide').find('#useridtest').text(), $(this).parents('.slide').find('.post-message').text(), $(this).parents('.slide').find('#gettest').text(), $(this).parents('.slide').find('#givetest').text(), $(this).parents('.slide').find('#save2test').text(), $(this).parents('.slide').find('#idtest').text(), $(this).parents('.slide').find('#offer_give_currency').text(), $(this).parents('.slide').find('#offer_receive_currency').text(), $(this).parents('.slide').find('#offer_give_currency_amount').text(), $(this).parents('.slide').find('#offer_receive_currency_amount').text()
    console.log("ok");
