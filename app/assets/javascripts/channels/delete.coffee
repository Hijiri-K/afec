App.delete = App.cable.subscriptions.create "DeleteChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    userIdTest = "." +data['userId']
    idTest = "." + data['id']
    console.log(idTest)
    console.log(userIdTest)
    $(idTest).remove()
    $(userIdTest).remove()


  delete: ->
    @perform 'delete'
