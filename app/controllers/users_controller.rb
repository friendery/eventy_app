class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @events = @user.events.paginate(page: params[:page], :per_page => 30).order('creatd_at DESC')
    @joinedevents = @user.joinedevents.paginate(page: params[:page], :per_page => 30).order('created_at DESC')
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Eventy!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def search
    @users = User.search(params[:search], params[:page])
  end
  
  def friendlist
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :photo,
                                   :hobby, :DOB, :gender, :nationality,
                                   :mobile, :occupation, :address,
                                   :webpage, :self_intro)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
