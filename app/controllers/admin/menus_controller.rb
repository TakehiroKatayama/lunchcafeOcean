class Admin::MenusController < Admin::BaseController
  before_action :set_menu, only: %i[show edit update destroy]

  def index
    @menus = Menu.order(menu_category: 'asc').all
  end

  def show; end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.create(menu_params)
    if @menu.save
      redirect_to admin_menus_path, success: 'メニューを追加しました'
    else
      flash.now['danger'] = 'メニューの追加に失敗しました'
      render :new
    end
  end

  def edit; end

  def update
    if @menu.update(menu_params)
      redirect_to admin_menus_path(@menu), success: 'メニューを編集しました'
    else
      flash.now['danger'] = 'メニューの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @menu.destroy!
    redirect_to admin_menus_path, success: 'メニューを削除しました'
  end

  private

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :content, :menu_category, :menu_image, :menu_image_cache)
  end
end
