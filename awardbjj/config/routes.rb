Rails.application.routes.draw do

  # use my custom registrations controller
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }

  root 'pages#home'
end