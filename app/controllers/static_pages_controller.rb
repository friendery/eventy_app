class StaticPagesController < ApplicationController
  def home
    @event = current_user.events.build if signed_in?
  end
  
  def help
  end
  
  def about
  end
  
  def contact
  end
end
