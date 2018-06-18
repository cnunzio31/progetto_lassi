Canard::Abilities.for(:player) do
  can [:show], Home
  can [:report, :showjoined, :showclosed, :showjoinable, :show, :exit], Session
  can [:blockinvitation, :unlockinvitation], User
  can [:index, :show, :show_current, :like], Match
  can [:create], Request
  can [:index, :accept], Invitation
  can [:create], Partecipationsmatch
end
