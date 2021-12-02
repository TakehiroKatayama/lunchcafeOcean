class Admin::ReservationsController < Admin::BaseController
  before_action :set_reservation, only: %i[show edit update]

  def index
    @reservations = Reservation.all.order(capacity_id: 'desc')
  end

  def show; end

  def new
    @reservation = Reservation.new
  end

  def create
    Reservation.transaction do
      capacity_id = Capacity.find_by(start_time: params[:reservation][:capacity_id]).id
      @reservation = Reservation.create!(reservation_params.merge(capacity_id: capacity_id))
      @reservation.capacity.update!(remaining_seat: @reservation.capacity.remaining_seat - @reservation.number_of_people)
      redirect_to admin_reservations_path, success: '予約が完了しました'
    end
  rescue StandardError
    flash.now['danger'] = "予約ができませんでした \n 今日以降の定休日以外の日付を入力してください \n 予約日の席数を確認してください"
    render :new
  end

  def edit; end

  def update
    Reservation.transaction do
      @capacity_id = Capacity.find_by(start_time: params[:reservation][:capacity_id]).id
      @reservation.capacity.update!(remaining_seat: @reservation.capacity.remaining_seat + @reservation.number_of_people)
      @reservation.update!(reservation_params.merge(capacity_id: @capacity_id))
      @reservation.capacity.update!(remaining_seat: @reservation.capacity.remaining_seat - @reservation.number_of_people)
      redirect_to admin_reservations_path, success: '予約の変更が完了しました'
    end
  rescue StandardError
    flash.now['danger'] = '予約の変更ができませんでした'
    render :edit
  end

  def destroy; end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phonenumber, :number_of_people, :visiting_time, :reservation_status, :capacity_id, :user_id)
  end
end
