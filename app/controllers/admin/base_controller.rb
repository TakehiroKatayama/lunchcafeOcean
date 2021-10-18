class Admin::BaseController < ApplicationController
  layout 'admin/layouts/application'
  before_action :check_admin
  add_flash_types :success, :info, :warning, :danger

  def not_authenticated
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path, warning: 'エラー' unless current_user.admin?
  end
end
