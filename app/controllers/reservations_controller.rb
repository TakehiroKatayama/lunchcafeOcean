class ReservationsController < ApplicationController
  def index
    @reservation = Reservation.new
  end

  def create
    Reservation.transaction do
      capacity_id = Capacity.find_by(start_time: params[:reservation][:capacity_id]).id
      @reservation = Reservation.create!(reservation_params.merge(capacity_id: capacity_id))
      @reservation.capacity.update!(remaining_seat: @reservation.decreased_capacity)
      redirect_to root_path, success: 'ご予約が完了しました。'
    end
  rescue StandardError
    redirect_to reservations_path, danger: 'ご予約ができませんでした。店舗までご連絡下さい。'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phonenumber, :number_of_people, :visiting_time, :reservation_status, :user_id)
  end
end
