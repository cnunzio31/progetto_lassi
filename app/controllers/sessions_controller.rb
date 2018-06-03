class SessionsController < ApplicationController
  def showactive
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
    @username = current_user.username
    @mysessions = Session.where(:master_id => current_user.id)
    @createdsessions = @mysessions.where(:status => 1)
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: createdsessionsmaster, joinablesessionsplayer
  end
  def showreported
    @username = current_user.username
    @reportedsessions = Session.where("reported_counter >= 1")
    @photos = Flickr.photos.search(user_id: "139197130@N06")
    #mockup: reportedsessions
  end
  def showjoined
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
    #visualizejoinablesessions
    @username = current_user.username
    @joinablesessions = Session.where(:private_flag => false).where("status == 1 OR status == 2")
  end
  def add_photo
    id = params[:id]
    @session = Session.find(id)
    s="session"+@session.title
    if !params[:images].nil?
        params[:images].each{ |image|
            photo_id = Flickr.upload(image, title: s)
        }
    end
    redirect_to session_path(@session)
  end
  def new
    #controller per la pagina di creazione della sessione del master (mockup: createnewsessionform)
  end
  def create
    #post di creazione della sessione del master (va insieme a new)
    @session = Session.create!(params[:session].permit(:title, :date, :location,:version,:session_type ,:description,:private_flag))
    .update(master_id:current_user.id,status:1)
    redirect_to home_path
  end
  def show
    #controller per visualizzare la sessione (mockup: session)
    @username = current_user.username
    id = params[:id]
    @session = Session.find(id)
    @master_username = User.find(@session.master_id).username
    partecipations = Partecipation.where(:session_id => id)
    @partecipants = partecipations.map { |x| User.find(x.player_id) }
    @currentmatch = Match.where(:session_id => id, :status => true)
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
  def exit
    #user decide di lasciare la sessione
    s_id = params[:session_id]
    p_id = current_user.id
    Partecipation.where(:session_id=>s_id).where(:player_id=>p_id).first.delete
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
