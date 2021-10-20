class StaticPagesController < ApplicationController
  def home
    @news = News.order(created_at: 'desc').first(5)
  end
end
