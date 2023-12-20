class EventsController < ApplicationController
  load_and_authorize_resource

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

end