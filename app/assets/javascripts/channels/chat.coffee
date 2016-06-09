App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.debug 'Connected to chat'

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.debug 'Disconnected from chat'

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if data.action == 'hide'
      $('#' + data.id).empty()
    else
      $('#room').append(data)

  speak: (message) ->
    @perform 'speak', message: message

  hide_message: (message_id) ->
    @perform 'hide_message', message_id: message_id

  $(document).on 'keypress', '#chat-input', (event) ->
    if event.keyCode == 13
      App.chat.speak(event.target.value)
      event.target.value = ""
      event.preventDefault

  $(document).on 'click', '.hide', (event) ->
    message_id = event.target.closest('div').id
    console.debug 'Hiding message ' + message_id
    App.chat.hide_message(message_id)
    event.preventDefault()
