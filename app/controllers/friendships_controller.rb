class FriendshipsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    @friend = User.find_by(id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Requested friendship"
      current_user.send_friend_request("request", params[:friend_id], @friendship.id)
      redirect_to @friend
    else
      flash[:error] = "Unable to request friendship."
      redirect_to @friend
    end
  end
  
  def index
    @friendshipOne = current_user.friendships
    @friendshipTwo = current_user.inverse_friendships
  end
  
  def update
    @friendship = current_user.inverse_friendships.find(params[:id])
    @friendship.status = 'approved'
    @friendship.save
    current_user.send_friend_request("approval", @friendship.user_id, @friendship.id)
    @msg = current_user.received_messages
    @msg = @msg.where(msgtype: 'friend')
    @msg = @msg.where(body: params[:id])
    @msg = @msg.where(subject: 'request')
    if @msg != nil
      @msg.each do |f|
        f.status = 'read'
        f.save
      end
    end
    redirect_to friendships_path
  end 

  def destroy
    if params[:inverse] == 'false'
      @friendship = current_user.friendships.find(params[:id])
    else
      @friendship = current_user.inverse_friendships.find(params[:id])
    end
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    @msg = current_user.received_messages
    @msg = @msg.where(msgtype: 'friend')
    @msg = @msg.where(body: params[:id])
    @msg = @msg.where(subject: 'request')
    if @msg != nil
      @msg.each do |f|
        f.status = 'read'
        f.save
      end
    end
    redirect_to friendships_path
  end
  
end