class Admin::NewsController < Admin::BaseController
  before_action :set_news, only: %i[show edit update destroy]

  def index
    @news = News.order(created_at: 'desc').page(params[:page])
  end

  def show; end

  def new
    @news = News.new
  end

  def create
    @news = News.create(news_params)
    if @news.save
      redirect_to admin_news_index_path, success: 'ニュースを投稿しました。'
    else
      flash.now['danger'] = 'ニュースの投稿に失敗しました。'
      render :new
    end
  end

  def edit; end

  def update
    if @news.update(news_params)
      redirect_to admin_news_index_path(@news), success: 'ニュースを更新しました。'
    else
      flash.now['danger'] = 'ニュースの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @news.destroy!
    redirect_to admin_news_index_path, success: 'ニュースを削除しました。'
  end

  private

  def set_news
    @news = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:title, :body, :category, :news_image, :news_image_cache)
  end
end
