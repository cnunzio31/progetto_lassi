class UsersController < ApplicationController
  def ban
    #post associata al tasto kick del master
    s_id = params[:session_id]
    p_id = params[:player_id]
    Partecipation.where(:session_id=>s_id).where(:player_id=>p_id).first.delete
    redirect_to home_path
  end
  def blockinvitation
    #post per bloccare gli inviti di un utente
    current_user.update_attributes(:invitation_flag => false)
    redirect_to home_path
  end
end
