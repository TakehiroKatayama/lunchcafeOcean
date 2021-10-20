class StaticPagesController < ApplicationController
  def home
    @news = News.latest
  end
end
