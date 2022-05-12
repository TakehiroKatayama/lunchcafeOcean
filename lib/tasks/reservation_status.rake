namespace :reservation_status do
  desc '今日の予約のステータス「来店予約」を「来店済み」に更新する'
  task update_reservation_status: :environment do
    Reservation.today_reservation.status_visitesd
  end
end
