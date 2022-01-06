class Admin::DashboardsController < Admin::BaseController
  def index
    @reservations = Reservation.one_week
    @contacts = Contact.one_week
  end
end
