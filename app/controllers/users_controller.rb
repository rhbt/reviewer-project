class UsersController < ApplicationController
  def index
    redirect_to new_user_path
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  private
    
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
end
