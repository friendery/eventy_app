class EventjoiningsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @user = User.find(params[:eventjoining][:user_id])
    @event = Event.find(params[:eventjoining][:event_id])
    @event.join!(@user)
    redirect_to @event
  end

  def destroy
    @event = Eventjoining.find(params[:id]).event
    @event.unjoin!(current_user)
    redirect_to @event
  end
end