class MatchesController < ApplicationController
  load_and_authorize_resource
  before_action :set_match, only: %i[add_scoreboard_values ]
  
  def index
  end

  def show
    @event = @match.bracket.event
  end

  def new
  end

  def edit
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

  private 
  def set_match
    @match = Match.find(params[:match_id])
  end

end