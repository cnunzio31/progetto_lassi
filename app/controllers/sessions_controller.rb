class SessionsController < ApplicationController
  def showactive
    @username = current_user.username
    @activesessions = Session.where(:status => 2)
    #mockup: activesessionsmaster, activesessionsplayer
  end
  def showclosed
    @username = current_user.username
    @closedsessions = Session.where(:status => 3)
    #mockup: endedsessionsmaster, endedsessionsplayer
  end
  def showcreated
    @username = current_user.username
    @createdsessions = Session.where(:status => 1)
    #mockup: createdsessionsmaster, joinablesessionsplayer
  end
  def showreported
    @username = current_user.username
    @reportedsessions = Session.where("reported_counter >= 1")
    #mockup: reportedsessions
  end
  def new
    #controller per la pagina di creazione della sessione del master (mockup: createnewsessionform)
  end
  def create
    #post di creazione della sessione del master (va insieme a new)
  end
  def show
    #controller per visualizzare la sessione (mockup: session)
    @username = current_user.username
    id = params[:id]
    @session = Session.find(id)
    partecipations = Partecipation.where(:session_id => id)
    @partecipants = partecipations.map { |x| User.find(x.player_id) }
    @currentmatch = Match.where(:session_id => id, :status => false)
  end
  def makeprivate
    #post associata al tasto make private della pagina session di show
  end
  def destroy
    #post del tasto delete dell'admin in show
  end
  def close
    #post del tasto close session del master in show
  end
  def report
    #post del tasto report session del player
  end
end
