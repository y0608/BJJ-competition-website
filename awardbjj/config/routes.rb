Rails.application.routes.draw do

  # use my custom registrations controller
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :events, only: [:index, :show]

  root 'pages#home'
end