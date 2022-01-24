class ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    render :index if @contact.invalid?
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.email(@contact).deliver_now
      redirect_to root_path, success: 'お問い合わせを送信しました。'
    else
      flash.now[:danger] = 'お問い合わせの送信に失敗しました。'
      render :index
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phonenumber, :category, :message)
  end
end
