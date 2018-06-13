class Match < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :data
  belongs_to :session
end
