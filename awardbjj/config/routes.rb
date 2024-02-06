Rails.application.routes.draw do
  # use my custom registrations controller
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :events do
    resources :brackets, only: [:show, :index]
    resources :brackets_and_matches, only: [:create]
    delete 'brackets_and_matches', to: 'brackets_and_matches#destroy'

    resources :matches , only: [:show, :index]
    resources :scoreboards, only: [:show]
    
    resources :registrations, only: [:create, :new] # TODO: edit, update, destroy

    post "/add_points1", to: "matches#add_points1"
    post "/add_advantages1", to: "matches#add_advantages1"
    post "/add_penalties1", to: "matches#add_penalties1"
  end
  
  # Should look like /registrations/?event_id=1 HOW?
  # post "/brackets_index_for_dropdown", to: "registrations#brackets_index_for_dropdown"  

  resources :registrations, only: [:index, :show]
  resources :users

  root 'pages#home'
end