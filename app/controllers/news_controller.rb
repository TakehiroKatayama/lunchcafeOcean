class NewsController < ApplicationController
  def index
    @news = News.category_list(params[:category]).order(created_at: 'desc').page(params[:page])
  end

  def show
    @news = News.find(params[:id])
    @recent_news = News.order(created_at: 'desc').first(5)
  end
end
