class PasswordResetsController < ApplicationController
  before_action :ensure_normal_user, only: :create

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to login_path, success: 'パスワードリセットメールを送信しました。'
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: 'パスワードを変更しました。'
    else
      flash.now[:danger] = 'パスワードを変更できませんでした。'
      render :edit
    end
  end

  def ensure_normal_user
    return unless params[:email] == User::GUEST_USER

    redirect_to root_path, danger: 'ゲストユーザーのパスワード再設定はできません。'
  end
end
