class HomesController < ApplicationController
  before_action :authenticate_user!
  def show
    @prova = "ciao a tutti"
  end
  def new
    authorize! :read, Home, :message => "Non puoi accedere alla risorsa selezionata"
  end
  def create
    authorize! :create, Home, :message => "Non puoi cambiare il tuo ruolo"
    #if(current_user.roles_mask == 4)
    #params.require(:roles_mask)
    role = params[:user][:roles_mask]
    #Rails.logger.debug("Salveeee #{role}")
    current_user.update_attributes(:roles_mask => role)
  end
end
