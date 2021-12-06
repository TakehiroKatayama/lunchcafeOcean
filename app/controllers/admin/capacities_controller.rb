class Admin::CapacitiesController < Admin::BaseController
  def index
    @capacities = Capacity.all
  end

  def show
    @capacity = Capacity.find(params[:id])
    @reservations = @capacity.reservations
  end
end
