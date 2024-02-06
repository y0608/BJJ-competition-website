class BracketsAndMatchesController < ApplicationController
	load_and_authorize_resource :event

	# TODO: do only once. If done twice, override the matches
	def create
		# for the future: add three person comeback, single elimination with bronze, ...
		# add an if else to check what create_matches returns
		@event.create_matches
		redirect_to event_brackets_path(@event), notice: 'Matches were successfully created.'
	end

	def destroy
		@event.brackets.each do |bracket|
			bracket.matches.delete_all # using delete_all, because it does not trigger callbacks
		end
    
		redirect_to event_brackets_path(@event), notice: 'Matches were successfully destroyed.'
	end
end
