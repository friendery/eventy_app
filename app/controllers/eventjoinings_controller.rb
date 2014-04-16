class EventjoiningsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @user = User.find(params[:eventjoining][:user_id])
    @event = Event.find(params[:eventjoining][:event_id])
    status = params[:eventjoining][:status]
    eventjoining_id = @event.join!(@user, status)
    if status == "approved"
      current_user.send_event_request("new_joiner", @event.user_id, eventjoining_id)
    elsif status == "pending"
      current_user.send_event_request("request", @event.user_id, eventjoining_id)
    end
    redirect_to @event
  end

  def destroy
    @event = Eventjoining.find(params[:id]).event
    if params[:user_id] == nil
      @event.unjoin!(current_user)
    else
      @user = User.find_by(id: params[:user_id])
      @event.unjoin!(@user)
    end
    @msg = current_user.received_messages
    @msg = @msg.where(msgtype: 'event')
    @msg = @msg.where(body: params[:id])
    @msg = @msg.where(subject: 'request')
    if @msg != nil
      @msg.each do |f|
        f.status = 'read'
        f.save
      end
    end
    redirect_to @event
  end
  
  def update
    @event = Eventjoining.find(params[:id]).event
    @eventjoining = Eventjoining.find(params[:id])
    @eventjoining.status = 'approved'
    @eventjoining.save
    current_user.send_event_request("approval", @eventjoining.user_id, params[:id])
    @msg = current_user.received_messages
    @msg = @msg.where(msgtype: 'event')
    @msg = @msg.where(body: params[:id])
    @msg = @msg.where(subject: 'request')
    if @msg != nil
      @msg.each do |f|
        f.status = 'read'
        f.save
      end
    end
    redirect_to @event
  end
end