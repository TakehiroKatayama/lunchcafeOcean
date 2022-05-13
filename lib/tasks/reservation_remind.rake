namespace :reservation_remind do
  desc '本日の予約がある場合、予約件数をSlackに通知する'
  task today_reservation_to_slack: :environment do
    @reservation = Reservation.count_today_reservation
    notifier = Slack::Notifier.new(
      Rails.application.credentials.slack[:notifier],
      channel: '#予約通知',
      username: '予約通知くん'
    )
    notifier.ping("本日の予約は#{@reservation}件です") if @reservation.positive?
  end
end
