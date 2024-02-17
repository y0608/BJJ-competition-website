class UsersController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    if @user.competitor?
      @pagy, @entries = pagy(@user.entries)
    else
      @pagy, @events = pagy(@user.events.order(start_at: :desc))
    end
  end
end
