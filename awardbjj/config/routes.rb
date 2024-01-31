Rails.application.routes.draw do
  # use my custom registrations controller
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :events do
    resources :brackets do
      resources :registrations
    end
  end

  resources :users

  root 'pages#home'
end