class Admin::ContactsController < Admin::BaseController
  before_action :set_contact, only: %i[show update destroy]
  def index
    @contacts = Contact.all.order(created_at: 'desc')
  end

  def show; end

  def update
    if @contact.update!(contact_params)
      redirect_to admin_contacts_path, success: 'ステータスを更新しました'
    else
      flash.now[:danger] = '対応ステータスを更新できませんでした'
      render :show
    end
  end

  def destroy
    @contact.destroy!
    redirect_to admin_contacts_path, success: 'お問い合わせを削除しました'
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:status)
  end
end
