Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: 'users/registrations'}

  resource :home, only: [:show, :create]
  resources :sessions, only: [:new, :show, :create, :destroy, :join, :exit] do
    resources :partecipations, only: [:create]
    resources :matches, only: [:new, :create, :index, :show] do
        resources :partecipationsmatch, only: [:create]
    end
  end
  resources :invitations, only: [:index, :new, :inviting]
  resources :requests, only: [:index,:create]
  #resources :movies do
  #  resources :reviews, only: [:new, :create, :destroy, :like]
  #end

  get 'activesessions', to: 'sessions#showactive', as: 'active_sessions'
  get 'createdsessions', to: 'sessions#showcreated', as: 'created_sessions'
  get 'closedsessions', to: 'sessions#showclosed', as: 'closed_sessions'
  get 'reportedsessions', to: 'sessions#showreported', as: 'reported_sessions'
  get 'joinablesessions', to: 'sessions#showjoinable', as: 'join_sessions'
  get 'joinedsessions', to: 'sessions#showjoined', as: 'joined_sessions'
  get 'sessions/:id/makeprivate', to: 'sessions#makeprivate', as: 'make_session_private'
  get 'sessions/:id/close', to: 'sessions#close', as: 'close_session'
  get 'sessions/:id/activate', to: 'sessions#activate', as: 'activate_session'
  get 'sessions/:id/report', to: 'sessions#report', as: 'report_session'
  #get 'sessions/:id/partecipations', to: 'partecipations#create', as: 'join_session'
  #get 'sessions/:id/partecipations', to: 'partecipations#create', as: 'join_session'

  post 'sessions/:session_id/exit', to: 'sessions#exit', as: 'exit_session'

  post 'users/:session_id/user/:player_id/ban', to: 'users#ban', as: 'ban_user'
  get 'users/blockinvitation', to: 'users#blockinvitation', as: 'block_invitation'
  get 'users/unlockkinvitation', to: 'users#unlockinvitation', as: 'unlock_invitation'

  get '/session/:session_id/matches/:match_id/like_match', to: 'matches#like', as: 'i_like_match'
  put '/session/:session_id/matches/:match_id/add_summary', to: 'matches#summary', as: 'add_summary_match'
  get '/session/:session_id/matches/:id/show_current', to: 'matches#show_current', as: 'show_current_match'
  get 'sessions/:session_id/matches/:id/close', to: 'matches#close', as: 'close_match'

  get 'requests/:id', to: 'requests#index', as: 'index_requests'
  post 'requests/:id/join', to: 'requests#create', as: 'create_requests'

  get 'session/:s_id/invite', to: 'invitations#new', as: 'new_invitations'
  post 'session/:s_id/users/:p_id/invite', to: 'invitations#inviting', as: 'send_invitations'
  post 'session/:s_id/users/:p_id/accept', to: 'invitations#accept', as: 'accept_invitations'

  put 'session/:session_id/add_photo/:id', to: 'sessions#add_photo', as: 'add_photo'
  put 'session/:session_id/matches/:match_id/add_photo_match/:id', to: 'matches#add_photo', as: 'add_photo_match'

  get '/redirect', to: 'matches#redirect', as: 'calendar_redirect'
  get '/callback', to: 'matches#callback', as: 'calendar_callback'
  get '/session/:session_id/matches/:match_id/calendars', to: 'matches#calendars', as: 'calendars'
  get '/session/:session_id/matches/:match_id/calendar/new_event/:calendar_id', to: 'matches#new_event', as: 'calendar_new_event', calendar_id: /[^\/]+/



  root :to => redirect('/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
