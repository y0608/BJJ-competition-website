class RegistrationsController < ApplicationController
    load_and_authorize_resource :event
    load_and_authorize_resource :bracket, through: :event
    load_and_authorize_resource :registration, through: :bracket

    def index
        # @registrations = @bracket.registrations
        @pagy, @registrations = pagy(@registrations, items: 10)
    end
end