class MessagesController < ApplicationController
  def create
    # @offer = Offer.find(params[:chatroom_id])
    @offer = Offer.find(params[:offer_id])
    # @product = Product.find(params[:product_id])
    @message = Message.new(message_params)
    @message.offer = @offer
    @message.user = current_user

    if @message.save
      ChatroomChannel.broadcast_to(@offer, render_to_string(partial: "messages/message", locals: { message: @message }))
    else
      render "offers/show", status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to current_user, status: :see_other
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end
