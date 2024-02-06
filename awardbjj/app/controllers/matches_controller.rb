class MatchesController < ApplicationController
    load_and_authorize_resource

    def index
    end

    def show
      @event = @match.bracket.event
    end

    def new
    end

    def edit
    end
  
    # def create
    #   if @match.save
    #     redirect_to match_url(@match), notice: 'Match was successfully created.'
    #   else
    #     render :new, status: :unprocessable_entity
    #   end
    # end
  
    # def update
    #   if @event.update(event_params)
    #     redirect_to event_url(@event), notice: 'Event was successfully updated.'
    #   else
    #     render :edit, status: :unprocessable_entity
    #   end
    # end
  
    def destroy
      @match.destroy
      redirect_to event_matches_url, notice: 'Match was successfully destroyed.'
    end
end