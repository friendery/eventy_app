class StaticPagesController < ApplicationController
  def home
    @event = current_user.events.build if signed_in?
    @user = User.rank(params[:page])
  end
  
  def help
  end
  
  def about
  end
  
  def contact
  end
end
