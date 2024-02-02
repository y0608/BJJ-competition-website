class BracketsAndMatchesController < ApplicationController
    def create
        # this implements the most simple way to generate the matches
        # for the future: single elimination brackets, three person comeback, ...
        @bracket = Bracket.find(params[:bracket_id])
        @bracket.create_matches
        redirect_to event_bracket_path(@bracket.event, @bracket)
    end
end
