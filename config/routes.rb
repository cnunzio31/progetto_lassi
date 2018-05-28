Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resource :home
  resource :sessions do
    resource :matches
    resource :invitations
    resource :partecipations
    resource :requests
  end
  #resources :movies do
  #  resources :reviews, only: [:new, :create, :destroy, :like]
  #end

  get 'activesessions', to: 'sessions#showactive', as: 'active_sessions'
  get 'createdsessions', to: 'sessions#showcreated', as: 'created_sessions'
  get 'closedsessions', to: 'sessions#showclosed', as: 'closed_sessions'

  root :to => redirect('/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
