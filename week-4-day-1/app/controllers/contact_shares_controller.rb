class ContactSharesController < ApplicationController
  def create
    @contact_share = Contact
      .find(params[:contact_id])
      .contact_shares.new(contact_shares_params)
  end

  def destroy
    @contact_share = ContactShare.find(params[:id])
    @contact_share.destroy

    render json: @contact_share
  end

  private

  def contact_shares_params
    params.require(:contact_share).permit(:user_id, :contact_id)
  end
end
