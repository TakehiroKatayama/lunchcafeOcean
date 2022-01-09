class Admin::MenusController < Admin::BaseController
  def index
    @menus = Menu.order(menu_category: 'asc').all
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def new
    @menu = Menu.new
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
      redirect_to admin_menus_path(@menu), success: 'メニューを編集しました'
    else
      flash.now['danger'] = 'メニューの更新に失敗しました'
      render :edit
    end
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

  private

  def menu_params
    params.require(:menu).permit(:name, :content, :menu_category, :menu_image, :menu_image_cache)
  end
end
