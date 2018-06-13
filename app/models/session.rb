class Session < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :version
  validates_presence_of :location

  has_many :matches
  has_many :request
  has_many :invitation
  has_many :partecipation
end
