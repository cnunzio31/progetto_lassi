class SessionsController < ApplicationController
  def showactive
    @activesessions = Session.where(:status => 2)
  end
  def showclosed
    @closedsessions = Session.where(:status => 3)
  end
  def showcreated
    @createdsessions = Session.where(:status => 1)
  end
end
