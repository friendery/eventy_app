class EventjoiningsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @user = User.find(params[:eventjoining][:user_id])
    @event = Event.find(params[:eventjoining][:event_id])
    status = params[:eventjoining][:status]
    @event.join!(@user, status)
    if status == "approved"
      current_user.send_event_request("New participator!", @event.user_id)
    elsif status == "pending"
      current_user.send_event_request("Event request received!", @event.user_id)
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
    redirect_to @event
  end
  
  def update
    @event = Eventjoining.find(params[:id]).event
    @eventjoining = Eventjoining.find(params[:id])
    @eventjoining.status = 'approved'
    @eventjoining.save
    current_user.send_event_request("Event equest approved!", @eventjoining.user_id)
    redirect_to @event
  end
end