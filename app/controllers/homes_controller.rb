class HomesController < ApplicationController
  before_action :authenticate_user!
  def show
    authorize! :show, Home, :message => "You can't read home page"
    @username = current_user.username
  end
  def create
    authorize! :create, Home, :message => "You can't change your role"
    role = params[:user][:roles_mask]
    #Rails.logger.debug("Salveeee #{role}")
    current_user.update_attributes(:roles_mask => role)
    redirect_to home_path
  end
end
