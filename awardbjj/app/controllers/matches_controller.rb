class MatchesController < ApplicationController
  load_and_authorize_resource
  # TODO: fix the loading so you can remove set_match
  before_action :set_match, only: %i[add_scoreboard_values start_timer pause_timer]
  before_action :end_match_params, only: [:end_match_submit]
  
  def index
  end

  def show
    @event = @match.bracket.event
  end

  def new
  end

  # def create
  #   if @match.save
  #     redirect_to match_url(@match), notice: 'Match was successfully created.'
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # def edit 
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


  def end_match
    @match = Match.find(params[:id]) # i don't know why it is id and not match_id. I should use set_match
    @event = @match.bracket.event
    @match.pause_timer
  end 

  def end_match_submit
    @match = Match.find(params[:id])
    @event = @match.bracket.event
    if @match.update(end_match_params.merge(status: "finished"))
      redirect_to event_match_path(@match.bracket.event, @match.id), notice: 'Match was successfully ended.'
    else
      render :show, status: :unprocessable_entity
    end
  end
  

  def start_timer
    @match.start_timer
    redirect_to event_scoreboard_path(@match.bracket.event, @match.id)
  end

  def pause_timer
    @match.pause_timer
    redirect_to event_scoreboard_path(@match.bracket.event, @match.id)
  end

  def add_scoreboard_values
    attribute = params[:attribute] + params[:competitor_index] # penalties1, points2, etc

    new_value = @match.send(attribute) + params[:number_to_add].to_i
    if new_value >= 0
      @match.send("#{attribute}=", new_value)
      @match.save!
    else
      new_value = 0
    end
    respond_to do |format|
      format.turbo_stream {
        render "display",
        locals: {
          info_to_display: new_value,
          turbo_tag: attribute
        }
      }
      # test without javascript
      format.html { redirect_to event_scoreboard_path(@match.bracket.event, @match.id) } # catch browsers that don't support turbo_stream
    end
  end


  private 
  def set_match
    @match = Match.find(params[:match_id])
  end

  def end_match_params
    params.require(:match).permit(:winner_id, :win_type)
  end
end