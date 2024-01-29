class BracketsController < ApplicationController
    
    def index
        @event = Event.find(params[:event_id])
        @brackets = @event.brackets.all
    end

    def show
        @event = Event.find(params[:event_id])
        @bracket = @event.brackets.find(params[:id])
    end

    private
        def event_params
            params.require(:event).permit()
        end
end
