class MessagesController < ApplicationController
  
    def index
      @messages = current_user.received_messages.where(status: 'unread')
      @messages = @messages.where(msgtype: 'msg')
      @messages.each do |f|
        f.update_attribute(:new_message, false)
      end
    end
  
    def create
      current_user.send_msg(params[:message][:subject], params[:message][:body], params[:message][:recipient_id])
      redirect_to '/'
    end
    
    def notification
      @messages = current_user.received_messages.where(status: 'unread')
      @messages = @messages.where('msgtype=? OR msgtype=?', 'friend', 'event')
      @messages.each do |f|
        f.update_attribute(:new_message, false)
      end
    end
  
    private
      def message_params
        params.require(:message).permit(:subject, :body, :recipient_id)
      end

end
