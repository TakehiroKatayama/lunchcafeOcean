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
    if @capacity.update(capacity_params)
      redirect_to admin_capacities_path, success: '席数を更新しました'
    else
      flash.now[:danger] = '席数を更新できませんでした'
      render :edit
    end
  end

  private

  def set_capacity
    @capacity = Capacity.find(params[:id])
  end

  def capacity_params
    params.require(:capacity).permit(:remaining_seat)
  end
end
