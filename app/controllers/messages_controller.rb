class MessagesController < ApplicationController
  def new
    @message = Message.new
  end
  def create
    @message = Message.new(message_params)

    if @message.valid?
      UserMailer.new_message(@message).deliver
      redirect_to contact_path, notice: "Ваше сообщение успешно отправлено."
    else
      flash[:danger] = "Ошибка при отправке сообщения."
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :content)
  end
end
