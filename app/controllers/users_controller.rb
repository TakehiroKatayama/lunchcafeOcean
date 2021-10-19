class UsersController < ApplicationController
  before_action :require_login, only: %i[show edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: '会員登録が完了しました。'
    else
      flash.now[:danger] = '会員登録に失敗しました。'
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
      redirect_to '/mypage', success: '登録情報を更新しました。'
    else
      flash.now[:danger] = '登録情報の更新に失敗しました。'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phonenumber, :password, :password_confirmation)
  end
end
