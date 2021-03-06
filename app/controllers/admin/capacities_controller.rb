class Admin::CapacitiesController < Admin::BaseController
  before_action :set_capacity, only: %i[show edit update]

  def index
    @capacities = Capacity.all
  end

  def show
    @reservations = @capacity.reservations
  end

  def edit; end

  def update
    Capacity.transaction do
      @capacity.update(capacity_params)
      @capacity.full? # 席数によりステータスを更新
    end
    redirect_to admin_capacities_path, success: '更新しました'
  rescue StandardError
    flash.now[:danger] = '更新できませんでした'
    render :edit
  end

  private

  def set_capacity
    @capacity = Capacity.find(params[:id])
  end

  def capacity_params
    params.require(:capacity).permit(:remaining_seat, :capacity_status)
  end
end
