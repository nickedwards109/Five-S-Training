class UsersController < ApplicationController
include UsersHelper
include SessionsHelper

before_action :logged_in_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
  	if @user.save
  	  flash[:success] = "You have successfully signed up!"
      log_in(@user)
      redirect_to lessons_path
  	else
      store_errors_in_session_hash
      redirect_to signup_path
  	end
  end

  def edit
    @user = User.find(params[:id])    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      flash[:success] = "You have successfully updated your profile!"
      redirect_to lessons_path
    end
  end

  private

  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def logged_in_user
    redirect_to login_path if !logged_in?
  end

end
