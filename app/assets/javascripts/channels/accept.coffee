App.accept = App.cable.subscriptions.create "AcceptChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
      $('.post-index-container').append data['accept']

  accept: (userid, message, get, give, save, id)->
    @perform 'accept', user_id: userid, message: message, get: get, give: give, save: save, id: id
    console.log(userid, message, get, give, save, id)

  $(document).on 'click', '.offer-decline', (event) ->
    console.log("accept");
    App.accept.accept $(this).parents('.slide').find('#useridtest').text(), $(this).parents('.slide').find('.post-message').text(), $(this).parents('.slide').find('#gettest').text(), $(this).parents('.slide').find('#givetest').text(), $(this).parents('.slide').find('#save2test').text(), $(this).parents('.slide').find('#idtest').text()
    console.log("ok");
