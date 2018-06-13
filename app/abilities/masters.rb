Canard::Abilities.for(:master) do
  can [:show], Home
  can [:show, :close, :makeprivate, :create, :new, :showcreated, :showactive, :showclosed, :add_photo, :makeprivate], Session
  can [:ban], User
  can [:new, :create, :index, :show, :show_current, :add_photo, :close, :summary], Match
  can [:index], Request
  can [:new, :inviting], Invitation
  can [:create], Partecipation
  end
