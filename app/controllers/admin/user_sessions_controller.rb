class Admin::UserSessionsController < Admin::BaseController
  layout 'admin/layouts/admin_login'
  skip_before_action :check_admin, only: %i[new create guest_login]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, success: 'ログアウトしました'
  end

  def guest_login
    guest_user = User.guest
    auto_login(guest_user)
    redirect_to admin_root_path, success: 'ゲストユーザーとしてログインしました。'
  end
end
