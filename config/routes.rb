Rails.application.routes.draw do
  resource :home
  resource :sessions
  resource :matches
  resource :invitations
  resource :partecipations
  resource :requests

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root :to => redirect('/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
