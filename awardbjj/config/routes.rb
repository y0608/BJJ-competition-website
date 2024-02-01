Rails.application.routes.draw do
  # use my custom registrations controller
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :events do
    resources :brackets, only: [:show, :index]
    resources :registrations, only: [:update, :edit, :destroy, :create, :new]
  end

  post "/brackets_index_for_dropdown", to: "registrations#brackets_index_for_dropdown"
  
  resources :registrations, only: [:index, :show]
  resources :users

  root 'pages#home'
end