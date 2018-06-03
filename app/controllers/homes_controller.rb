class HomesController < ApplicationController
  before_action :authenticate_user!
  def show
    authorize! :show, Home, :message => "You can't read home page"
    @username = current_user.username
  end
  def create
    authorize! :create, Home, :message => "You can't change your role"
    #if(current_user.roles_mask == 4)
    #params.require(:roles_mask)
    role = params[:user][:roles_mask]
    #Rails.logger.debug("Salveeee #{role}")
    current_user.update_attributes(:roles_mask => role)
    if current_user.provider=="google_oauth2"
        redirect_to calendar_redirect_path
    else
        redirect_to home_path
    end
  end
end
