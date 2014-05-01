class StaticPagesController < ApplicationController
  def home
    @event = current_user.events.build if signed_in?
  end
  
  def explore
    @users = User.joins(:events).group("users.id").having("count(events.id) >= 2")
    @user = @users.find(:all, :order => "rate DESC", :limit => 10)
    @event = Event.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  def help
  end
  
  def about
  end
  
  def contact
  end
end
