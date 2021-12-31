class Admin::ContactsController < Admin::BaseController
  def index
    @contacts = Contact.all.order(created_at: 'desc')
  end

  def show; end
end
