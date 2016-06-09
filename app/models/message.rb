class Message < ApplicationRecord
  def hide
    HideMessageJob.perform_later(id)
  end
end
