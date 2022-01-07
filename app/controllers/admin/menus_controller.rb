class Admin::MenusController < Admin::BaseController
  def index
    @menus = Menu.order(category: 'asc').all
  end
end
