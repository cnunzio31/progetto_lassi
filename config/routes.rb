Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resource :home, only: [:show, :create]
  resources :sessions, only: [:new, :show, :create, :destroy] do #with s you see :id
    resources :matches, only: [:new, :create, :index, :show]
    resources :invitations, only: [:index]
    resources :partecipations, only: [:create]
    resources :requests, only: [:index]
  end
  #resources :movies do
  #  resources :reviews, only: [:new, :create, :destroy, :like]
  #end

  get 'activesessions', to: 'sessions#showactive', as: 'active_sessions'
  get 'createdsessions', to: 'sessions#showcreated', as: 'created_sessions'
  get 'closedsessions', to: 'sessions#showclosed', as: 'closed_sessions'
  get 'reportedsessions', to: 'sessions#showreported', as: 'reported_sessions'
  get 'sessions/:id/makeprivate', to: 'sessions#makeprivate', as: 'make_session_private'
  get 'sessions/:id/close', to: 'sessions#close', as: 'close_session'
  get 'sessions/:id/report', to: 'sessions#report', as: 'report_session'

  get 'users/:id/ban', to: 'users#ban', as: 'ban_user'

  get '/session/:id/matches/:id/like_match/:id', to: 'session_match#like', as: 'i_like_match'
  get '/session/:id/matches/:id/add_summary/:id', to: 'session_match#summary', as: 'add_summary_match'

  root :to => redirect('/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
