class SessionsController < ApplicationController
  before_action :authenticate_user!
  def showactive
    authorize! :showactive, Session, :message => "You can't read showactive page"
    @username = current_user.username
    if current_user.has_role?(:master)
        @mysessions = Session.where(:master_id => current_user.id)
        @activesessions = @mysessions.where(:status => 2)
    elsif current_user.has_role?(:player)
        @partecipations=Partecipation.where(:player_id => current_user.id)
        @activesessions=[]
        @partecipations.each do |p|
            @session=Session.find(p.session_id)
            if @session.status==2
                @activesessions.push(@session)
            end
        end
    end
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: activesessionsmaster, activesessionsplayer
  end
  def showclosed
    authorize! :showclosed, Session, :message => "You can't read showclosed page"
    @username = current_user.username
    if current_user.has_role?(:master)
        @mysessions = Session.where(:master_id => current_user.id)
        @closedsessions = @mysessions.where(:status => 3)
    elsif current_user.has_role?(:player)
        @partecipations=Partecipation.where(:player_id => current_user.id)
        @closedsessions=[]
        @partecipations.each do |p|
            @session=Session.find(p.session_id)
            if @session.status==3
                @closedsessions.push(@session)
            end
        end
    end
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: endedsessionsmaster, endedsessionsplayer
  end
  def showcreated
    authorize! :showcreated, Session, :message => "You can't read showcreated page"
    @username = current_user.username
    @mysessions = Session.where(:master_id => current_user.id)
    @createdsessions = @mysessions.where(:status => 1)
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: createdsessionsmaster, joinablesessionsplayer
  end
  def showreported
    authorize! :showreported, Session, :message => "You can't read showreported page"
    @username = current_user.username
    @reportedsessions = Session.where("reported_counter >= 1")
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: reportedsessions
  end
  def showjoined
    authorize! :showjoined, Session, :message => "You can't read showjoined page"
    @username = current_user.username
    @partecipations=Partecipation.where(:player_id => current_user.id)
    @joinedsessions=[]
    @partecipations.each do |p|
        @session=Session.find(p.session_id)
        if @session.status!=3
            @joinedsessions.push(@session)
        end
    end
    @photos = Flickr.photos.search(user_id: "139197130@N06")
  end
  def showjoinable
    authorize! :showjoinable, Session, :message => "You can't read showjoinable page"
    #visualizejoinablesessions
    @username = current_user.username
    @joinablesessions = Session.where(:private_flag => false).where("status == 1 OR status == 2")
  end
  def add_photo
    authorize! :add_photo, Session, :message => "You can't add photos"
    id = params[:id]
    @session = Session.find(id)
    if @session.master_id != current_user.id
      redirect_to session_path(id)
    end
    s="session"+@session.title
    if !params[:images].nil?
        params[:images].each{ |image|
            photo_id = Flickr.upload(image, title: s)
        }
    end
    redirect_to session_path(@session)
  end
  def new
    authorize! :new, Session, :message => "You can't create new session"
    #controller per la pagina di creazione della sessione del master (mockup: createnewsessionform)
  end
  def create
    authorize! :create, Session, :message => "You can't create new session"
    #post di creazione della sessione del master (va insieme a new)
    @session = Session.create!(params[:session].permit(:title, :date, :location,:version,:session_type ,:description,:private_flag))
    .update(master_id:current_user.id,status:1)
    redirect_to home_path
  end
  def show
    authorize! :show, Session, :message => "You can't see session"
    #controller per visualizzare la sessione (mockup: session)
    @username = current_user.username
    id = params[:id]
    @session = Session.find(id)
    @master_username = User.find(@session.master_id).username
    if current_user.has_role?(:master) and current_user.id != @session.master_id
      redirect_to home_path
    end
    partecipations = Partecipation.where(:session_id => id)
    @partecipants = partecipations.map { |x| User.find(x.player_id) }
    @val = Partecipation.where(:session_id => id, :player_id => current_user.id).count
    @currentmatch = Match.where(:session_id => id, :status => true)
    s="session"+@session.title
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    @latlong = Geocoder.coordinates(@session.location)
    @matches=Match.where(:session_id => id).count
  end
  def makeprivate
    authorize! :makeprivate, Session, :message => "You can't make private this session"
    #post associata al tasto make private della pagina session di show
    id = params[:id]
    session = Session.find(id)
    if session.master_id != current_user.id
      redirect_to session_path(id)
    end
    if session.private_flag
    	session.update(private_flag:false)
    else
	     session.update(private_flag:true)
    end
    redirect_to session_path(id)
  end
  def exit
    authorize! :exit, Session, :message => "You can't exit from session"
    #user decide di lasciare la sessione
    s_id = params[:session_id]
    p_id = current_user.id
    Partecipation.where(:session_id=>s_id).where(:player_id=>p_id).first.delete
    redirect_to home_path
  end
  def destroy
    authorize! :destroy, Session, :message => "You can't destroy session"
    #post del tasto delete dell'admin in show
  end
  def close
    authorize! :close, Session, :message => "You can't close session"
    #post del tasto close session del master in show
    id = params[:id]
    session = Session.find(id)
    if session.master_id != current_user.id
      redirect_to session_path(id)
    end
    @session = session.update(status:3)
    redirect_to home_path
  end
  def report
    authorize! :report, Session, :message => "You can't report session"
    id = params[:id]
    session = Session.find(id)
    report = session.reported_counter + 1
    session.update_attributes(:reported_counter => report)
    redirect_to session_path(id)
    #post del tasto report session del player
  end
end
