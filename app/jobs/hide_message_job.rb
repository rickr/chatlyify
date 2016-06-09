class HideMessageJob < ApplicationJob
  def perform(message_id)
    Message.find(message_id).update_attribute(:hidden, true)
    ActionCable.server.broadcast('hide', { action: 'hide', id: message_id } )
  end
end
