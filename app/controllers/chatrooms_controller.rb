class ChatroomsController < ApplicationController

  def show
    @chatroom = Offer.find(params[:id])
    @message = Message.new
  end

end
