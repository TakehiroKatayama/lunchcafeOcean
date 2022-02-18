class MenusController < ApplicationController
  def index
    @lunchs = Menu.where(menu_category: 'lunch')
    @sweets = Menu.where(menu_category: 'cake')
    @wholecakes = Menu.where(menu_category: 'wholecake')
    @others = Menu.where(menu_category: 'others')
  end
end
