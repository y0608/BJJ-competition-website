Rails.application.routes.draw do
  # use my custom registrations controller
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  # TODO: IMPORTANT - I need to fix the clash between the registrations controller and the devise registrations controller
  # renaming to entries
  
  resources :events do
    resources :brackets, only: [:show, :index]
    resources :brackets_and_matches, only: [:create]
    delete "brackets_and_matches", to: "brackets_and_matches#destroy"

    resources :matches , only: [:show, :index]

    # resources :scoreboards, only: [:show]
    get "scoreboard/:match_id", to: "scoreboards#show", as: "scoreboard"
    post "scoreboard/:match_id/pause_timer", to: "matches#pause_timer", as: "pause_timer"
    post "scoreboard/:match_id/start_timer", to: "matches#start_timer", as: "start_timer"

    resources :entries, only: [:create, :new]

    post "/add_scoreboard_values", to: "matches#add_scoreboard_values"
  end


  # Should look like /entries/?event_id=1 HOW?
  # post "/brackets_index_for_dropdown", to: "entries#brackets_index_for_dropdown"  

  resources :entries, only: [:index, :show]
  resources :users

  root "pages#home"
end