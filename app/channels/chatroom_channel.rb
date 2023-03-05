class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Offer.find(params[:id])
    stream_for chatroom
    # stream_from "offer_chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
