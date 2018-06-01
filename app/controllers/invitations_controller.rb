class InvitationsController < ApplicationController
  def index
    @username = current_user.username
    @invitations = Invitation.where(:player_id => @username)
  end
  def new
    #metodo per prendere la form per la creazine di un nuovo invito
  end
end
