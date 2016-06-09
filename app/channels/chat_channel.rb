# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
     stream_from 'messages'
     stream_from 'hide'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create content: data['message']
    ActionCable.server.broadcast('messages',
     ApplicationController.render(partial: 'messages/message', locals: { message: message })
    )
  end

  def hide_message(data)
    Rails.logger.debug "Hiding message #{data['message_id']}"
    HideMessageJob.perform_later(data['message_id'])
  end
end
