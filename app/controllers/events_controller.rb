class EventsController < ApplicationController
  before_action :signed_in_user

  def new
    @event = Event.new
  end
  
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def event_params
      params.require(:event).permit(:title, :description)
    end
end