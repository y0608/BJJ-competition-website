class EndMatchesController < ApplicationController
  authorize_resource class: false

  before_action :set_match

  def new
    @match.pause_timer
  end

  def create
    if @match.update(end_match_params.merge(status: "finished"))
      if @match.next_match
        if @match.next_match.competitor1.nil?
          @match.next_match.update(competitor1: @match.winner)
        elsif @match.next_match.competitor2.nil?
          @match.next_match.update(competitor2: @match.winner)
        end
      end
      if @match.round == 0
        @match.bracket.set_winners
      end
      redirect_to event_match_path(@match.bracket.event, @match), notice: 'Match was successfully ended.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
  def set_match
    @match = Match.find(params[:id])
    @event = @match.bracket.event
  end

  def end_match_params
    params.require(:match).permit(:winner_id, :win_type)
  end
end
