module ApplicationHelper
  def page_title
    if params[:category] == 'event'
      'イベント'
    elsif params[:category] == 'menu'
      'メニュー'
    elsif params[:category] == 'campaign'
      'キャンペーン'
    end
  end
end
