Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resource :home, only: [:show, :create]
  resources :sessions, only: [:new, :show, :create, :destroy] do #with s you see :id
    resources :matches, only: [:new, :create, :index, :show]
    resources :partecipations, only: [:create]
  end
  resources :invitations, only: [:index, :new]
  resources :requests, only: [:index,:create]
  #resources :movies do
  #  resources :reviews, only: [:new, :create, :destroy, :like]
  #end

  get 'activesessions', to: 'sessions#showactive', as: 'active_sessions'
  get 'createdsessions', to: 'sessions#showcreated', as: 'created_sessions'
  get 'closedsessions', to: 'sessions#showclosed', as: 'closed_sessions'
  get 'reportedsessions', to: 'sessions#showreported', as: 'reported_sessions'
  get 'sessions/:id/makeprivate', to: 'sessions#makeprivate', as: 'make_session_private'
  get 'sessions/:id/close', to: 'sessions#close', as: 'close_session'
  get 'sessions/:id/activate', to: 'sessions#activate', as: 'activate_session'
  get 'sessions/:id/report', to: 'sessions#report', as: 'report_session'
  #get 'sessions/:id/partecipations', to: 'partecipations#create', as: 'join_session'
  #get 'sessions/:id/partecipations', to: 'partecipations#create', as: 'join_session'

  get 'users/:id/ban', to: 'users#ban', as: 'ban_user'
  get 'users/blockinvitation', to: 'users#blockinvitation', as: 'block_invitation'

  get '/session/:session_id/matches/:id/like_match', to: 'matches#like', as: 'i_like_match'
  get '/session/:session_id/matches/:id/add_summary', to: 'matches#summary', as: 'add_summary_match'

  get 'requests/:id', to: 'requests#index', as: 'index_requests'
  post 'requests/:id/join', to: 'requests#create', as: 'create_requests'

  get 'session/:session_id/photo/:id', to: 'sessions#photo', as: 'photo'
  put 'session/:session_id/add_photo/:id', to: 'sessions#add_photo', as: 'add_photo'

  root :to => redirect('/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
