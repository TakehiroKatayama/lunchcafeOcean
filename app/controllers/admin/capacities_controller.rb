class Admin::CapacitiesController < Admin::BaseController
  def index
    @capacities = Capacity.all
  end
end
