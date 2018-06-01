class PartecipationsController < ApplicationController
  def create
    #post per creare una nuova partecipazione, associata all'index del request e al tasto join del player
    #creo partecipation
   # id = params[:pid]
    r_id = params[:session_id] #to change
    request = Request.find(r_id)
    @partecipation = Partecipation.create!(:session_id => request.session_id,:player_id => request.player_id)
    Request.find(r_id).delete
    #distruggo sessione
    redirect_to home_path
  
  #  t.integer "session_id"
  #  t.integer "player_id"
  end
end
