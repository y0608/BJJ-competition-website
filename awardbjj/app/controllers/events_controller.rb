class EventsController < ApplicationController
  load_and_authorize_resource

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to event_url(@event), notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      redirect_to event_url(@event), notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    def event_params
      params.require(:event).permit(:name, :location, :game_type, :start_at, :end_at)
    end
end