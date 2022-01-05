class Admin::DashboardsController < Admin::BaseController
  def index
    @reservations = Reservation.all.order(created_at: 'desc')
  end
end
