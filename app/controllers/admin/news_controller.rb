class Admin::NewsController < Admin::BaseController
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

  def update; end

  def destroy; end

  def news_params
    params.require(:news).permit(:title, :body, :category)
  end
end
