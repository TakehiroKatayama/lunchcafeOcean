namespace :reservation_status do
  desc '本日の予約のステータス「来店予約」をステータスを「来店済み」に変更する'
  task update_reservation_status: :environment do
    Reservation.where(reservation_status: 'visiting', capacity_id: Capacity.find_by(start_time: Time.zone.today).id).update(reservation_status: 'visited')
  end
end
