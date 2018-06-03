class PartecipationsController < ApplicationController
  before_action :authenticate_user!
  def create
    authorize! :create, Partecipation, :message => "You can't create partecipations"
    #post per creare una nuova partecipazione, associata all'index del request e al tasto join del player
    r_id = params[:session_id] #to change
    request = Request.find(r_id)
    if current_user.has_role?(:master) and Session.find(r_id).master_id != current_user.id
      redirect_to home_path
    elsif current_user.has_role?(:player) and request.player_id == current_user.id
      redirect_to home_path
    end
    @partecipation = Partecipation.create!(:session_id => request.session_id,:player_id => request.player_id)
    Request.find(r_id).delete
    redirect_to home_path
  end
end
