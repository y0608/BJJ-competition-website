Rails.application.routes.draw do
  # use my custom controllers for devise:
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions",
    unlocks: "users/unlocks"
  }

  # TODO: check ability.rb for permissions!
  #   e.g scoreboard/:match_id/pause_timer only organizer!

  resources :events do
    resources :brackets, only: [:show, :index] do
      resources :bracket_entries, only: [:index], path: "entries", as: "entries"
      resources :brackets_and_matches, only: [:index], path: "matches", as: "matches"
    end

    resources :brackets_and_matches, only: [:create]
    delete "brackets_and_matches", to: "brackets_and_matches#destroy"

    resources :matches, only: [:show, :index] do
      member do
        patch :end_match_submit, to: 'end_matches#create'
        get :end_match, to: 'end_matches#new'
      end
    end

    get "scoreboard/:match_id", to: "scoreboards#show", as: "scoreboard"
    post "scoreboard/:match_id/pause_timer", to: "matches#pause_timer", as: "pause_timer"
    post "scoreboard/:match_id/start_timer", to: "matches#start_timer", as: "start_timer"

    resources :entries, only: [:index, :create, :new]

    post "/add_scoreboard_values", to: "matches#add_scoreboard_values", as: "add_scoreboard_values"
  end

  # post "/brackets_index_for_dropdown", to: "entries#brackets_index_for_dropdown"  

  resources :users, except: [:index]

  root "pages#home"
end