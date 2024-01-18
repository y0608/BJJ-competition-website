Rails.application.routes.draw do
  # use my custom registrations controller
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :events

  resources :users

  root 'pages#home'
end