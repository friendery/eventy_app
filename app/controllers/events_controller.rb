class EventsController < ApplicationController
  before_action :signed_in_user, except: [:search]
  before_action :correct_user,  only: [:edit, :update, :destroy]

  def new
    @event = Event.new
  end
  
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created!"
      redirect_to @event
    else
      render 'static_pages/home'
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def members
    @event = Event.find(params[:id])
    @eventjoinings = @event.eventjoinings.all
  end

  def destroy
    @user = current_user
    @event.destroy
    redirect_to @user
  end
  
  def search
      @events = Event.search(params[:search])
  end
  
  def edit
    @event = Event.find(params[:id])
  end

  def update
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated"
      redirect_to @event
    else
      render 'edit'
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :avatar)
    end
    
    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
end