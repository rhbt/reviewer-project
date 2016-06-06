class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user,   only: [:show, :edit, :update]
  
  def index
    redirect_to new_user_path
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in(@user)
      redirect_to root_url
    else
      render "new"
    end
    
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your account has been updated."
      redirect_to @user
    else
      render "edit"
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
end
