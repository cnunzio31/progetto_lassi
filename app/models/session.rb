class Session < ActiveRecord::Base
  has_many :matches
  has_many :request
  has_many :invitation
  has_many :partecipation
end
