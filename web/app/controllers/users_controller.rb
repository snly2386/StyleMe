class UsersController < ApplicationController
  def new

  end

  def show
    @user = StyleMe.db.get_user(params[:id])
    @username = @user.username
    @email = @user.email 
    @name = @user.name
    @age = @user.age 
    @about_me = @user.about_me
    @gender = @user.gender 
  end

  def create

    result = StyleMe::SignUp.run(:username => params[:username], :name => params[:name], :gender => params[:gender], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
    @user = result.user
    @username = @user.username

    result2 = StyleMe::SignIn.run(:username => @user.username)

    @session = result2.session

    if result2.success?
      # UserMailer.signup_confirmation(result.user.id)
      redirect_to "/users/#{@user.id}"
    end
  end


  private
  def user_params
    params.permit(:username, :name, :gender, :password, :email)
  end
end
