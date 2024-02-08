Rails.application.routes.draw do
  # use my custom registrations controller
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :events do
    resources :brackets, only: [:show, :index]
    resources :brackets_and_matches, only: [:create]
    delete "brackets_and_matches", to: "brackets_and_matches#destroy"

    resources :matches , only: [:show, :index]

    # resources :scoreboards, only: [:show]
    get "scoreboard/:match_id", to: "scoreboards#show", as: "scoreboard"
    post "scoreboard/:match_id/pause_timer", to: "matches#pause_timer", as: "pause_timer"
    post "scoreboard/:match_id/start_timer", to: "matches#start_timer", as: "start_timer"

    resources :registrations, only: [:create, :new] # TODO: edit, update, destroy

    post "/add_scoreboard_values", to: "matches#add_scoreboard_values"
    # post "/add_points", to: "matches#add_points"
    # post "/add_advantages", to: "matches#add_advantages"
    # post "/add_penalties", to: "matches#add_penalties"
  end


  
  # Should look like /registrations/?event_id=1 HOW?
  # post "/brackets_index_for_dropdown", to: "registrations#brackets_index_for_dropdown"  

  resources :registrations, only: [:index, :show]
  resources :users

  root "pages#home"
end