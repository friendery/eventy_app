class EventjoiningsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @user = current_user
    @event = Event.find(id: params[:id]
    @event.join!(@user.id)
  end

  def destroy
    @event.unjoin!(current_user)
    redirect_to @event
  end
end