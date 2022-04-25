class Admin::CapacitiesController < Admin::BaseController
  before_action :set_capacity, only: %i[show edit update closed]

  def index
    @capacities = Capacity.all
  end

  def show
    @reservations = @capacity.reservations
  end

  def edit; end

  def update
    if @capacity.update(capacity_params)
      @capacity.full? # 席数によりステータスを更新
      redirect_to admin_capacities_path, success: '更新しました'
    else
      flash.now[:danger] = '更新できませんでした'
      render :edit
    end
  end

  def closed
    if @capacity.update!(remaining_seat: 0)
      redirect_to admin_capacities_path, success: '休業日に設定しました'
    else
      flash.now[:danger] = '休業日に設定できませんでした'
      render :index
    end
  end

  private

  def set_capacity
    @capacity = Capacity.find(params[:id])
  end

  def capacity_params
    params.require(:capacity).permit(:remaining_seat, :capacity_status)
  end
end
