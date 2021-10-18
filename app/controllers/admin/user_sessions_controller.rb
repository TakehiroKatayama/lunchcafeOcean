class Admin::UserSessionsController < Admin::BaseController
  layout 'admin/layouts/admin_login'
  skip_before_action :check_admin, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to admin_login_path
  end
end
