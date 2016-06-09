class RoomsController < ApplicationController
  def show
    @messages = Message.where(hidden: false)
  end
end
