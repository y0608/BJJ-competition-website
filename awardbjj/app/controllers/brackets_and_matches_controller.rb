class BracketsAndMatchesController < ApplicationController
	load_and_authorize_resource :event

	# TODO: do only once. If done twice, override the matches
	def create
		# this implements the most simple way to generate the matches for all brackets of an event
		# for the future: single elimination brackets, three person comeback, ...
		@event.create_matches
		redirect_to event_brackets_path(@event), notice: 'Matches were successfully created.'
	end

	def destroy
		@event.brackets.each do |bracket|
			bracket.matches.destroy_all
			puts "Matches destroyed for bracket #{bracket.id}"
		end
    
		redirect_to event_brackets_path(@event), notice: 'Matches were successfully destroyed.'
	end
end
