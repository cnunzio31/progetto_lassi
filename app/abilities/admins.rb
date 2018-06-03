Canard::Abilities.for(:admin) do
  can [:show], Home
  can [:show, :destroy, :showreported], Session
  can [:index, :show, :show_current], Match
end
