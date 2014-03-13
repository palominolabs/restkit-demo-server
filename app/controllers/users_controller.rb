class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_signup_params)
    if @user.save
      redirect_to root_url, notice: 'Signed up!'
    else
      render :new
    end
  end

  private
  def user_signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
