class EventsController < ApplicationController
  before_action :signed_in_user, except: [:search]
  before_action :correct_user,  only: [:edit, :update, :destroy]

  def new
    @event = Event.new
  end
  
  def create
    @event = current_user.events.build(event_params) 
    if @event.save
      @event.join!(current_user, 'approved') 
      @event.convertTime
      flash[:success] = "Event created!"
      redirect_to @event
    else
      render 'static_pages/home'
    end
  end
  
  def show
    @event = Event.find(params[:id])
    if 
      @rate = Rate.find_by(event_id: @event.id, user_id: current_user.id)
    else
      @rate = Rate.create(event_id: @event.id, user_id: current_user.id, score: 0) 
    end
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
    if params[:when] == ""
      date=""
      time_period=""
    else
      datetime = params[:when]
      pos = datetime.index('|')
      if !pos.blank?
        date = datetime.from(0).to(9)
        time_period = datetime.from(11).to(-1)
      else
        if datetime.length == 10
          date = datetime
          time_period = ""
        else
          date = ""
          time_period = datetime
        end
      end
    end
    @events = Event.search(params[:what], date, time_period, params[:region])
                   .paginate(:page => params[:page], :per_page => 30, :order => 'created_at DESC')
  end
  
  def edit
    @event = Event.find(params[:id])
  end

  def update
    if @event.update_attributes(event_params)     
      @event.convertTime
      flash[:success] = "Event updated"
      redirect_to @event
    else
      render 'edit'
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :avatar, :date, :time, :capacity, :region, :street)
    end
    
    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
    
    def convert_time()
    end
end