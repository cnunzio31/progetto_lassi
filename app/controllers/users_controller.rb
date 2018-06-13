class UsersController < ApplicationController
  before_action :authenticate_user!
  def ban
    authorize! :ban, User, :message => "You can't ban users"
    #post associata al tasto kick del master
    s_id = params[:session_id]
    if Session.find(s_id).master_id != current_user.id
      redirect_to home_path
    end
    p_id = params[:player_id]
    Partecipation.where(:session_id=>s_id).where(:player_id=>p_id).first.delete
    redirect_to home_path
  end
  def blockinvitation
    authorize! :blockinvitation, User, :message => "You can't block invitations"
    #post per bloccare gli inviti di un utente
    current_user.update_attributes(:invitation_flag => false)
    redirect_to home_path
  end
  def blockinvitation
    #post per bloccare gli inviti di un utente
  end
end
