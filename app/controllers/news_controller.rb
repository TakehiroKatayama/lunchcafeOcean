class NewsController < ApplicationController
  def index
    @news = News.order(created_at: 'desc').page(params[:page])
  end
end
