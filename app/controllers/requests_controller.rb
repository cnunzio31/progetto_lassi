class RequestsController < ApplicationController
  def create
    id = current_user.id
    s_id = params[:id]
    @request = Request.create!(:session_id => s_id,:player_id => id)
    redirect_to home_path
  end
  def index
  #mochup: pendingrequest
    @username = current_user.username
    s_id = params[:id]
    @activerequests = Request.where(:session_id => s_id)
  end
end
