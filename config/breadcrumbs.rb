crumb :root do
  link 'Home', root_path
end

crumb :news do
  link 'お知らせ', news_index_path
  parent :root
end

crumb :show_news do |news|
  news = News.find(params[:id])
  link news.title.to_s, news_path(news)
  parent :news
end

crumb :menu do
  link 'メニュー', menus_path
  parent :root
end

crumb :shop do
  link '店舗情報', shop_path
  parent :root
end

crumb :contact do
  link 'お問い合わせ', contacts_path
  parent :root
end

crumb :reservation do
  link 'ランチのご予約', reservations_path
  parent :root
end

crumb :reservation do
  link 'ランチのご予約', reservations_path
  parent :root
end

crumb :login do
  link 'ログイン', login_path
  parent :root
end

crumb :user do
  link '会員登録', new_user_path
  parent :root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
