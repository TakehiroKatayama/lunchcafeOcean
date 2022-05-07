require 'exception_notification/rails'

ExceptionNotification.configure do |config|
  config.add_notifier :slack,
                      webhook_url: Rails.application.credentials.slack[:notifier],
                      channel: '#エラー' # 通知したいチャンネル名
end
