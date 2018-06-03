class PartecipationsmatchController < ApplicationController
  before_action :authenticate_user!
    def create
      authorize! :create, Partecipationsmatch, :message => "You can't create match's partecipations"
      s_id = params[:session_id]
      @session = Session.find(s_id)
      m_id = params[:match_id]
    	@match = Match.find(m_id)
      @partecipationmatch = Partecipationsmatch.create(:session_id => s_id,:match_id => m_id, :player_id => current_user.id)
      redirect_to session_match_path(@session,@match)
    end
end
