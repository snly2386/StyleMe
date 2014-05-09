class UsersController < ApplicationController
  def new

  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    user.save
    closet = Closet.new(closet_params)
    closet.save
    redirect_to root_path
  end

  def show
    
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :age, :about_me, :gender, :closet, :password)
  end

  def closet_params
    params.require(:closet).permit(:photobooths, :user_id)
  end
end
