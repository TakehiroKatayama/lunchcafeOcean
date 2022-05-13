namespace :reservation_remind do
  desc '本日の予約がある場合、予約件数をSlackに通知する'
  task today_reservation_to_slack: :environment do
    @capacity_id = Capacity.find_by(start_time: Time.zone.today).id
    @reservation = Reservation.where(capacity_id: @capacity_id).count
    notifier = Slack::Notifier.new(
      Rails.application.credentials.slack[:notifier],
      channel: '#予約通知',
      username: '予約通知くん'
    )
    notifier.ping("本日の予約は#{@reservation}件です") if @reservation.positive?
  end
end
