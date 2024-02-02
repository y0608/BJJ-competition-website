class BracketsAndMatchesController < ApplicationController
	load_and_authorize_resource :event

	def create
		# this implements the most simple way to generate the matches for all brackets of an event
		# for the future: single elimination brackets, three person comeback, ...
		@event.create_matches
		redirect_to event_brackets_path(@event)
	end
end
