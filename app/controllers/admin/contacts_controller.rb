class Admin::ContactsController < Admin::BaseController
  def index
    @contacts = Contact.all.order(created_at: 'desc')
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update!(contact_params)
      redirect_to admin_contacts_path, success: 'ステータスを更新しました'
    else
      flash.now[:danger] = '対応ステータスを更新できませんでした'
      render :show
    end
  end

  def contact_params
    params.require(:contact).permit(:status)
  end
end
