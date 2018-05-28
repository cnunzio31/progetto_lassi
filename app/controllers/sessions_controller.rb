class SessionsController < ApplicationController
  def showactive
    @username = current_user.username
    @activesessions = Session.where(:status => 2)
  end
  def showclosed
    @username = current_user.username
    @closedsessions = Session.where(:status => 3)
  end
  def showcreated
    @username = current_user.username
    @createdsessions = Session.where(:status => 1)
  end
end
