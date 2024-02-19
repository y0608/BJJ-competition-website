class BracketsAndMatchesController < ApplicationController
	load_and_authorize_resource :event

	def create
		if @event.matches.empty?
			if @event.create_matches
				redirect_to event_brackets_path(@event), notice: 'Matches were successfully created.'
			else
				redirect_to event_brackets_path(@event), notice: 'Matches were not successfully created.'
			end
		else
			redirect_to event_brackets_path(@event), alert: 'Matches have already been created.'
		end
	end

	def destroy
		if @event.matches.empty?
			# TODO: don't reload full page, use flash.now[:notice] = 'There are no matches to destroy.'
			redirect_to event_brackets_path(@event), notice: 'There are no matches to destroy.'
		else
			@event.brackets.each do |bracket|
				bracket.matches.delete_all # using delete_all, because it does not trigger callbacks
        bracket.update(first_place: nil, second_place: nil, third_place: nil, third_place2: nil)
      end
			redirect_to event_brackets_path(@event), notice: 'Matches were successfully destroyed.'
		end
	end
end
