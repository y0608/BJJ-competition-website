class BracketsController < ApplicationController
    load_and_authorize_resource :event
    load_and_authorize_resource :bracket, through: :event

    def index
        # @brackets = @brackets.has_registrations
        @pagy, @brackets = pagy(@brackets, items: 10)
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
        if @bracket.save
            redirect_to event_bracket_url(@bracket), notice: 'Bracket was successfully created.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        if @bracket.update(bracket_params)
          redirect_to event_bracket_url(@bracket), notice: 'Bracket was successfully updated.'
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @bracket.destroy
        redirect_to events_url, notice: 'Bracket was successfully destroyed.'
    end

    private
        def bracket_params
            params.require(:event).permit(:event_id)
        end
end
