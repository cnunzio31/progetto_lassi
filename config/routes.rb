Rails.application.routes.draw do
  resource :home
  devise_for :users
  root :to => redirect('/home')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
