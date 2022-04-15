class Admin::ReservationsController < Admin::BaseController
  before_action :set_reservation, only: %i[show edit update destroy cancel status_update]
  before_action :assign_to_capacity_id, only: %i[create update]

  def index
    @q = Reservation.ransack(params[:q])
    @reservations = @q.result.order(capacity_id: 'desc').page(params[:page])
  end

  def show; end

  def new
    @reservation = Reservation.new
  end

  def create
    Reservation.transaction do
      @reservation = Reservation.create!(reservation_params.merge(capacity_id: @capacity_id))
      @reservation.capacity.update!(remaining_seat: @reservation.decreased_capacity)
    end
    redirect_to admin_reservations_path, success: '予約が完了しました'
  rescue StandardError => e
    redirect_to new_admin_reservation_path, danger: e.message
  end

  def edit; end

  def update
    Reservation.transaction do
      @reservation.capacity.update!(remaining_seat: @reservation.increased_capacity)
      @reservation.update!(reservation_params.merge(capacity_id: @capacity_id))
      @reservation.capacity.update!(remaining_seat: @reservation.decreased_capacity)
    end
    redirect_to admin_reservations_path, success: '予約の変更が完了しました'
  rescue StandardError
    flash.now['danger'] = '予約の変更ができませんでした'
    render :edit
  end

  def status_update
    if @reservation.update!(reservation_params)
      redirect_to admin_reservations_path, success: '変更が完了しました'
    else
      flash.now['danger'] = '更新に失敗しました'
      render :show
    end
  end

  def destroy
    Reservation.transaction do
      @reservation.capacity.update!(remaining_seat: @reservation.increased_capacity)
      @reservation.destroy!
    end
    redirect_to admin_reservations_path, success: '予約を削除しました'
  end

  def cancel
    Reservation.transaction do
      @reservation.capacity.update!(remaining_seat: @reservation.increased_capacity)
      @reservation.update!(reservation_status: 'cancel')
    end
    redirect_to admin_reservations_path, success: 'キャンセルが完了しました'
  rescue StandardError
    flash.now['danger'] = 'キャンセルできませんでした'
    render :show
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def assign_to_capacity_id
    @capacity_id = Capacity.find_by(start_time: params[:reservation][:capacity_id]).id
  end

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phonenumber, :number_of_people, :visiting_time, :reservation_status, :capacity_id, :user_id)
  end
end
