class ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    render :index if @contact.invalid?
  end

  def back
    @contact = Contact.new(contact_params)
    render :index
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.email(@contact).deliver_now
      view_context.contact_to_slack
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
