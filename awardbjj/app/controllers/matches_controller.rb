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

  def add_points1
    # TODO: check to which to add: points1 or 2
    @match = Match.find(params[:match_id])
    @match.points1 += params[:number_to_add].to_i
    @match.save!
    
    render turbo_stream: turbo_stream.replace(
      # TODO: ask why should i pass this partial? It only contains <%= points %>
      "points1", partial: "matches/points", locals: { points: @match.points1 }
    )
  end

  def add_advantages1
    @match = Match.find(params[:match_id])
    @match.advantages1 += params[:number_to_add].to_i
    @match.save!
    
    render turbo_stream: turbo_stream.replace(
      "advantages1", partial: "matches/advantages", locals: { advantages: @match.advantages1 }
    )
  end

  def add_penalties1
    @match = Match.find(params[:match_id])
    @match.penalties1 += params[:number_to_add].to_i
    @match.save!
    
    render turbo_stream: turbo_stream.replace(
      "penalties1", partial: "matches/penalties", locals: { penalties: @match.penalties1 }
    )
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