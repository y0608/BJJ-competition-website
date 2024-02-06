class ScoreboardsController < ApplicationController
    def show
        @match = Match.find(params[:match_id])
        authorize! :update, @match.bracket.event
    end
end
