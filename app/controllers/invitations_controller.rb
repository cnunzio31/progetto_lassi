class InvitationsController < ApplicationController
  before_action :authenticate_user!
  def index
    authorize! :index, Invitation, :message => "You can't see invitations"
    @username = current_user.username
    @id = current_user.id
    @invitations = Invitation.where(:player_id => @id)
  end
  def new
    authorize! :new, Invitation, :message => "You can't send invitations"
    #metodo per visualizzare gli utenti che possono essere invitati
    @username = current_user.username
    id = params[:s_id]
    @session = Session.find(id)
    if current_user.id != @session.master_id
      redirect_to home_path
    end
    @eligibleusers = User.where("roles_mask == 2").where(:invitation_flag => true)
  end
  def inviting
    authorize! :inviting, Invitation, :message => "You can't send invitations"
    s_id = params[:s_id]
    p_id = params[:p_id]
    if Session.find(s_id).master_id != current_user.id
      redirect_to session_path(s_id)
    end
    @invitation = Invitation.create!(:session_id => s_id,:player_id => p_id)
    redirect_to session_path(s_id)
  end
  def accept
    authorize! :new, Invitation, :message => "You can't accept invitations"
    s_id = params[:s_id]
    p_id = params[:p_id]
    if p_id != current_user.id
      redirect_to session_path(s_id)
    end
    invite = Invitation.where(:session_id => s_id).where(:player_id => p_id).first
    if invite == nil
      redirect_to home_path
    end
    invite.delete
    @partecipations = Partecipation.create!(:session_id => s_id, :player_id => p_id)
    redirect_to session_path(s_id)
  end
end
