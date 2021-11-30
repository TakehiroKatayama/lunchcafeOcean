class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order(created_at: :desc).page(params[:page])
  end

  def show
    @reservations = @user.reservations.order(created_at: :desc).page(params[:page]).per(User::PER_PAGE)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: 'アカウント情報を編集しました'
    else
      flash.now['danger'] = 'アカウント情報の変更に失敗しました'
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: 'アカウントを削除しました'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phonenumber, :role)
  end
end
