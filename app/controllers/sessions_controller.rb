class SessionsController < ApplicationController
  def showactive
    @username = current_user.username
    @activesessions = Session.where(:status => 2)
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: activesessionsmaster, activesessionsplayer
  end
  def showclosed
    @username = current_user.username
    @closedsessions = Session.where(:status => 3)
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: endedsessionsmaster, endedsessionsplayer
  end
  def showcreated
    @username = current_user.username
    @createdsessions = Session.where(:status => 1)
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: createdsessionsmaster, joinablesessionsplayer
  end
  def showreported
    @username = current_user.username
    @reportedsessions = Session.where("reported_counter >= 1")
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: reportedsessions
  end
  def add_photo
    @username = current_user.username
    id = params[:id]
    @session = Session.find(id)
    if !params[:images].nil?
        params[:images].each{ |image|
            photo_id = Flickr.upload(image, title: @session.title)
        }
    end
    redirect_to session_path(@session)
  end
  def new
    #controller per la pagina di creazione della sessione del master (mockup: createnewsessionform)
  end
  def create
    #post di creazione della sessione del master (va insieme a new)
    @session = Session.create!(params[:session].permit(:title, :date, :location, :description, :version,:private_flag))
    .update(master_id:current_user.id,status:1)
    redirect_to home_path
  end
  def show
    #controller per visualizzare la sessione (mockup: session)
    @username = current_user.username
    id = params[:id]
    @session = Session.find(id)
    partecipations = Partecipation.where(:session_id => id)
    @partecipants = partecipations.map { |x| User.find(x.player_id) }
    @currentmatch = Match.where(:session_id => id, :status => false)
    @photos = Flickr.photos.search(user_id: "139197130@N06")
  end
  def makeprivate
    #post associata al tasto make private della pagina session di show
    id = params[:id]
    if Session.find(id).private_flag
    	Session.find(id).update(private_flag:false)
    else
	Session.find(id).update(private_flag:true)
    end
    redirect_to home_path
  end
  def activate
    #post del tasto close session del master in show
    id = params[:id]
    @session = Session.find(id).update(status:2)
    redirect_to home_path
  end
  def destroy
    #post del tasto delete dell'admin in show
  end
  def close
    #post del tasto close session del master in show
    id = params[:id]
    @session = Session.find(id).update(status:3)
    redirect_to home_path
  end
  def report
    #post del tasto report session del player
  end
end
