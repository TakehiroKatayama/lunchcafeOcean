class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: 'アカウント情報を編集しました'
    else
      flash.now['danger'] = 'アカウント情報の変更に失敗しました'
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phonenumber, :role)
  end
end
