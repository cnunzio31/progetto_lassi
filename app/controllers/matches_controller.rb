class MatchesController < ApplicationController
  before_action :authenticate_user!
  def new
    authorize! :new, Match, :message => "You can't create matches"
    id = params[:session_id]
    @session = Session.find(id)
    @matches=@session.matches.all
    @matches.each do |match|
      if match.status==true
        flash[:notice] = "There is already the match #{match.title} to play. Close it before creating another one"
        redirect_to session_path(@session) and return
      end
    end
    id = params[:session_id]
    @session = Session.find(id)
    if current_user.id != @session.master_id
      redirect_to home_path
    end
    @master_username = User.find(@session.master_id).username
  end

def create
    authorize! :create, Match, :message => "You can't create matches"
    id = params[:session_id]
    @session = Session.find(id)
    if @session.master_id != current_user.id
      redirect_to home_path
    end
    @session.update(status:2)
    @master_username = User.find(@session.master_id).username
    if params[:match][:title]==""
        flash[:warnings] = "Insert Title"
        redirect_to new_session_match_path(@session)
    else
        @match = @session.matches.create(params[:match].permit(:title, :data))
        puts @match.valid?
        flash[:notice] = "#{@match.title} was successfully created."
	    redirect_to session_path(@session)
    end
  end


  def index
    authorize! :index, Match, :message => "You can't see matches"
    @username = current_user.username
    id = params[:session_id]
    @session = Session.find(id)
    if current_user.has_role?(:master) and current_user.id != @session.master_id
      redirect_to home_path
    end
    @matches=@session.matches.sort_by{ |m| m.like}.reverse
  end

  def show
    authorize! :show, Match, :message => "You can't see matches"
    id = params[:session_id]
    @session = Session.find(id)
    id = params[:id]
    if current_user.has_role?(:master) and current_user.id != @session.master_id
      redirect_to home_path
    end
    @match=Match.find(id)
    @master_username = User.find(@session.master_id).username
    if current_user.email.split("@")[1].to_s.casecmp?("test.com")
        @photos=[]
    else
        s="Session"+@session.title+"match"+@match.title
        @photos = Flickr.photos.search(user_id: "139197130@N06", title: s)
    end
  end

  def show_current
    authorize! :show_current, Match, :message => "You can't see current match"
    id = params[:session_id]
    current_user.update(current_session_id: id)
    if current_user.has_role?(:player)
        @partecipationmatch = Partecipationsmatch.where(:player_id => current_user.id)
    end
    @session = Session.find(id)
    if current_user.has_role?(:master) and current_user.id != @session.master_id
      redirect_to home_path
    end
    @matches=@session.matches
    @matches.each do |match|
        if match.status==true
            @match=match
            current_user.update(current_match_id: @match.id)
            @username = current_user.username
            @master_username = User.find(@session.master_id).username
            if current_user.email.split("@")[1].to_s.casecmp?("test.com")
                @photos=[]
            else
                s="Session"+@session.title+"match"+@match.title
                @photos = Flickr.photos.search(user_id: "139197130@N06", title: s)
            end
            return
        end
    end
    redirect_to session_path(@session)
  end

  def like
    authorize! :like, Match, :message => "You can't add like"
    id = params[:session_id]
    @session = Session.find(id)
    id_match = params[:match_id]
  	@match = Match.find(id_match)
  	if @match.like.present?
  	  l = @match.like + 1
  	else
  	  l = 1
  	end
  	@match.update(like: l)
  	redirect_to session_match_path(@session,@match)
  end

  def add_photo
    authorize! :add_photo, Match, :message => "You can't add photos"
    id = params[:session_id]
    @session = Session.find(id)
    id = params[:match_id]
    @match = Match.find(id)
    if @session.master_id != current_user.id
      redirect_to session_match_path(@session,@match)
    end
    s="Session"+@session.title+"match"+@match.title
    if !params[:images].nil?
        params[:images].each{ |image|
            photo_id = Flickr.upload(image, title: s)
        }
    end
    redirect_to session_match_path(@session,@match)
  end

  def close
    authorize! :close, Match, :message => "You can't close matches"
    @username = current_user.username
    id = params[:session_id]
    @session = Session.find(id)
    id = params[:id]
	  @match = Match.find(id)
    if @session.master_id != current_user.id
      redirect_to session_match_path(@session,@match)
    end
    @master_username = User.find(@session.master_id).username
  end

  def summary
    authorize! :summary, Match, :message => "You can't change summary"
    s_id = params[:session_id]
    @session = Session.find(s_id)
    m_id = params[:match_id]
  	@match = Match.find(m_id)
    if @session.master_id != current_user.id
      redirect_to session_match_path(@session,@match)
    end
  	@match.update_attributes!(params[:match].permit(:summary))
    @match.update(status: false)
    @match.update(status: false)
    redirect_to session_matches_path(@session,@match)
  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)
    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]
    response = client.fetch_access_token!
    session[:authorization] = response
    current_user.update(calendar_flag: true)
    @session = Session.find(current_user.current_session_id)
    @match = Match.find(current_user.current_match_id)
    redirect_to calendars_path(@session,@match)
  end

  def calendars
    if !current_user.calendar_flag
        redirect_to calendar_redirect_path
    else
        current_user.update(calendar_flag: false)
        s_id = params[:session_id]
        @session = Session.find(s_id)
        m_id = params[:match_id]
        @match = Match.find(m_id)
        client = Signet::OAuth2::Client.new(client_options)
        client.update!(session[:authorization])
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        @calendar_list = service.list_calendar_lists
        c_id=0
        @calendar_list.items.each do |c|
            c_id=c.id
            break
        end
        redirect_to calendar_new_event_path(@session,@match,c_id)
    end
  end

  def new_event
    s_id = params[:session_id]
    @session = Session.find(s_id)
    m_id = params[:match_id]
  	@match = Match.find(m_id)
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])
    service = Google::Apis::CalendarV3::CalendarService.new
    puts service
    service.authorization = client
    d=@match.data.to_date
    s="Session: "+@session.title+";Match: "+@match.title
    event = Google::Apis::CalendarV3::Event.new({
      start: Google::Apis::CalendarV3::EventDateTime.new(date: d),
      end: Google::Apis::CalendarV3::EventDateTime.new(date: d),
      summary: s
    })
    service.insert_event(params[:calendar_id], event)
    flash[:notice]="Added to calendar"
    redirect_to session_match_path(@session,@match)
  end

  private

  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR, #The AUTH_CALENDAR scope gives you read+write access
      redirect_uri: calendar_callback_url
    }
  end
end
