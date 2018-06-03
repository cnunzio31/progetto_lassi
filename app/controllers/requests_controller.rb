class RequestsController < ApplicationController
  before_action :authenticate_user!
  def create
    authorize! :create, Request, :message => "You can't create request"
    id = current_user.id
    s_id = params[:id]
    @request = Request.create!(:session_id => s_id,:player_id => id)
    redirect_to home_path
  end
  def index
    authorize! :index, Request, :message => "You can't see pending request"
  #mochup: pendingrequest
    @username = current_user.username
    s_id = params[:id]
    if current_user.id != Session.find(s_id).master_id
      redirect_to home_path
    end
    @activerequests = Request.where(:session_id => s_id)
  end
end
