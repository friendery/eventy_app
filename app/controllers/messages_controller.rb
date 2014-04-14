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
      @friendmsg = @messages.where(msgtype: 'friend')
      @eventmsg = @messages.where(msgtype: 'event')
      @messages.each do |f|
        f.update_attribute(:new_message, false)
      end
    end
    
    def update
      @message = Message.find_by(id: params[:id])
      @message.status = 'read'
      @message.save
      redirect_to notification_messages_path
    end

end
