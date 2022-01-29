class ReservationsController < ApplicationController
  def index
    @reservation = Reservation.new
  end

  def confirm
    capacity_id = Capacity.find_by(start_time: params[:reservation][:capacity_id]).id
    @reservation = Reservation.new(reservation_params.merge(capacity_id: capacity_id))
    return unless @reservation.invalid?

    flash.now[:danger] = 'ご来店日は日曜日、月曜日以外の日付を選択して下さい。'
    render :index
  end

  def back
    @reservation = Reservation.new(reservation_params)
    render :index
  end

  def create
    Reservation.transaction do
      @reservation = Reservation.create!(reservation_params)
      @reservation.capacity.update!(remaining_seat: @reservation.decreased_capacity)
      ReservationMailer.email(@reservation).deliver_now
      redirect_to root_path, success: 'ご予約が完了しました。'
    end
  rescue StandardError
    redirect_to reservations_path, danger: 'ご予約ができませんでした。店舗までご連絡下さい。'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phonenumber, :number_of_people, :visiting_time, :reservation_status, :user_id, :capacity_id)
  end
end
