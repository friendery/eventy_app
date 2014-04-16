module ApplicationHelper
  # Returns the full title on a per-page basis.
   def full_title(page_title)
     base_title = "Friendery Sample App"
     if page_title.empty?
       base_title
     else
       "#{base_title} | #{page_title}"
     end
   end
   
  def notify_count
    @messages = current_user.received_messages.where(new_message: true)
    @messages = @messages.where(status: 'unread')
	  noticount = @messages.where('msgtype=? OR msgtype=?', 'friend', 'event').count
  end
  
  def msg_count
	  @messages = current_user.received_messages.where(new_message: true)
    msgcount = @messages.where(msgtype: 'msg').count
  end
end
