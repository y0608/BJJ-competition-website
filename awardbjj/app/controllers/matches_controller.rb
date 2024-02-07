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
    new_points = @match.points1 + params[:number_to_add].to_i
    if new_points >= 0
      @match.points1 += params[:number_to_add].to_i
      @match.save!
    end
    
    # TODO: ask why should i pass this partial? It only contains <%= points %>
    # respond_to do |format|
    #   format.turbo_stream {}
    #   format.html { redirect_to rooth_path }
    # end
  end

  def add_advantages1
    @match = Match.find(params[:match_id])
    new_advantages = @match.advantages1 + params[:number_to_add].to_i
    if new_advantages >= 0
      @match.advantages1 = new_advantages
      @match.save!
      # WHY does it work without resond_to?
      # respond_to do |format|
      #   format.turbo_stream {}
      #   format.html { redirect_to rooth_path }
      # end
    end
  end

  def add_penalties1
    @match = Match.find(params[:match_id])
    new_penalties = @match.penalties1 + params[:number_to_add].to_i
    if new_penalties >= 0
      @match.penalties1 = new_penalties
      @match.save!
    end
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