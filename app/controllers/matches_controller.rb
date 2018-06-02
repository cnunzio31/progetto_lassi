class MatchesController < ApplicationController

  def new
    id = params[:session_id]
    @session = Session.find(id)
    @master_username = User.find(@session.master_id).username
  end

  def create
    id = params[:session_id]
    @session = Session.find(id)
    @session.update(status:2)
    @master_username = User.find(@session.master_id).username
    @matches=Match.all
    @matches.each do |match|
      if match.status==true
        flash[:notice] = "There is already the match #{match.title} to play. Close it before creating another one"
        redirect_to session_path(@session) and return
      end
    end
	@match = @session.matches.create!(params[:match].permit(:title, :data))
	flash[:notice] = "#{@match.title} was successfully created."
	redirect_to session_path(@session)
  end

  def index
    @username = current_user.username
    id = params[:session_id]
    @session = Session.find(id)
    @matches=@session.matches
  end

  def show
    id = params[:session_id]
    @session = Session.find(id)
    id = params[:id]
    @match=Match.find(id)
    @master_username = User.find(@session.master_id).username
    @photos = Flickr.photos.search(user_id: "139197130@N06")
  end

  def show_current
    if current_user.has_role?(:player)
        @partecipationmatch = Partecipationsmatch.where(:player_id => current_user.id)
    end
    id = params[:session_id]
    @session = Session.find(id)
    @matches=@session.matches
    @matches.each do |match|
        if match.status==true
            @match=match
            @username = current_user.username
            @master_username = User.find(@session.master_id).username
            @photos = Flickr.photos.search(user_id: "139197130@N06")
            return
        end
    end
    redirect_to session_path(@session)
  end

  def like
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
    id = params[:session_id]
    @session = Session.find(id)
    id = params[:match_id]
    @match = Match.find(id)
    s="match"+@match.title
    if !params[:images].nil?
        params[:images].each{ |image|
            photo_id = Flickr.upload(image, title: s)
        }
    end
    redirect_to session_match_path(@session,@match)
  end

  def close
    @username = current_user.username
    id = params[:session_id]
    @session = Session.find(id)
    id = params[:id]
	@match = Match.find(id)
    @master_username = User.find(@session.master_id).username
  end

  def summary
    s_id = params[:session_id]
    @session = Session.find(s_id)
    m_id = params[:match_id]
	@match = Match.find(m_id)
	@match.update_attributes!(params[:match].permit(:summary))
    @match.update(status: false)
    @match.update(status: false)
    redirect_to session_matches_path(@session,@match)
  end
end
