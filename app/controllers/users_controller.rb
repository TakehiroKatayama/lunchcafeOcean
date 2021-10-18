class UsersController < ApplicationController
  before_action :require_login, only: %i[show edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  def show; end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to '/mypage'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phonenumber, :password, :password_confirmation)
  end
end
