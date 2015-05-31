class ContactsController < ApplicationController
  def create
    @contact = User.find(params[:user_id]).contacts.new(contacts_params)
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: 422
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: @contact
  end

  def index
    if params[:user_id]
      @contact = Contact.find_by(user_id: params[:user_id])
      render json: @contact
    else
      @contact = Contact.all
      render json: @contact
    end
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(user_params)
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: 422
    end
  end

  private

  def contacts_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
