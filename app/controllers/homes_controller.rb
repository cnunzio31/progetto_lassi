class HomesController < ApplicationController
  before_action :authenticate_user!
  def show
    @prova = "ciao a tutti"
  end
  def new
    authorize! :read, Home, :message => "Non puoi accedere alla risorsa selezionata"
  end
  def edit
    if(current_user.roles_mask != nil)
      redirect_to home_path
      return
    end
    #render html: "it's works"
  end
  def create
    if(current_user.roles_mask == nil)
      #params.require(:roles_mask)
      role = params[:user][:roles_mask]
      #Rails.logger.debug("Salveeee #{role}")
      current_user.update_attributes(:roles_mask => role)
    end
  end
end
