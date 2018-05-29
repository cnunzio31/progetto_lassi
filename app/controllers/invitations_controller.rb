class InvitationsController < ApplicationController
  def index
    @username = current_user.username
    @activesessions = Session.where(:status => 2)
  end
end
