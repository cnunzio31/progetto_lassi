class InvitationsController < ApplicationController
  def index
    @username = current_user.username
    @id = current_user.id
    @invitations = Invitation.where(:player_id => @id)
  end
  def new
    #metodo per visualizzare gli utenti che possono essere invitati
    @username = current_user.username
    id = params[:s_id]
    puts id
    @session = Session.find(id)
    @eligibleusers = User.where("roles_mask == 2").where(:invitation_flag => true)
  end
  def inviting
    s_id = params[:s_id]
    p_id = params[:p_id]
    @invitation = Invitation.create!(:session_id => s_id,:player_id => p_id)
    redirect_to home_path
  end
  def accept
    s_id = params[:s_id]
    p_id = params[:p_id]
    Invitation.where(:session_id => s_id).where(:player_id => p_id).first.delete
    @partecipations = Partecipation.create!(:session_id => s_id, :player_id => p_id)
    redirect_to home_path
  end
end
