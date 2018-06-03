class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :authentications
  has_many :partecipations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]
  #validates_format_of :roles_mask, with: /[1-2]/#, :on => :create

  acts_as_user :roles => [ :master, :player, :notdefined, :admin ]
end
