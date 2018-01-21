App.offer = App.cable.subscriptions.create "OfferChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    # $('.post-index-container').prepend data['offer']
    # $('.recieved-offer').append data['offer']
    $('.slideSet').append data['offer']
    $('.offer-modal-wrapper-test').fadeIn();


  offer: (userid, message, get, give, save, id, save2) ->
    @perform 'offer', user_id: userid, message: message, get: get, give: give, save: save, id: id, save2: save2
    console.log(userid, message, get, give, save, id, save2)

  $(document).on 'click', '#offersubmit', (event) ->
    console.log("send");
    App.offer.offer $('#post-userid').text(), $('#postmessageshow').text(), $('#getshow').text(), $('#giveshow').text(), $('#post_offer_savemoffer').text(), $('#post-myid').text(), $('#saveshow').text()
    console.log("send");
    $('.modal').animate({"top": "-200px"},500);
    $('.show-modal-wrapper').fadeOut(500);
    $('.modal').animate({"top": "270px"},0);