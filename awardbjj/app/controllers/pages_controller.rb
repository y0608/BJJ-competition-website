class PagesController < ApplicationController
  def home
    events_to_load = 4
    @events = Event.where("start_at >= ?", Time.now).order(start_at: :asc).limit(events_to_load)
    if @events.empty?
      @events = Event.where("start_at < ?", Time.now).order(start_at: :desc).limit(events_to_load)
    end
  end
end
