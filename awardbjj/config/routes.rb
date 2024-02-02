Rails.application.routes.draw do
  # use my custom registrations controller
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :events do
    resources :brackets, only: [:show, :index]
    resources :matches , only: [:show, :index] # I can't do brackets/:bracket_id/matches/:id :( HOW?
    resources :registrations, only: [:create, :new] # TODO: edit, update, destroy
  end
  # Should look like /registrations/?event_id=1 HOW?
  # post "/brackets_index_for_dropdown", to: "registrations#brackets_index_for_dropdown"
  
  resources :registrations, only: [:index, :show]
  resources :users

  root 'pages#home'
end