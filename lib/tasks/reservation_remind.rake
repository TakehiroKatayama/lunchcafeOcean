namespace :reservation_remind do
  desc '本日の予約がある場合、予約件数をSlackに通知する'
  task today_reservation_to_slack: :environment do
    notifier = Slack::Notifier.new(
      Rails.application.credentials.slack[:notifier],
      channel: '#予約通知',
      username: '予約通知くん'
    )
    notifier.ping("本日の予約は#{Reservation.count_today_reservation}件です") if Reservation.count_today_reservation.positive?
  end
end
