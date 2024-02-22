class BracketEntriesController < ApplicationController
  load_and_authorize_resource :event
  load_and_authorize_resource :bracket, through: :event
  load_and_authorize_resource :entry, through: :bracket

  # Actions for listing entries within a bracket
  def index
    @pagy, @entries = pagy(@bracket.entries)
  end
end
