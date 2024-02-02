class RegistrationsController < ApplicationController
	load_and_authorize_resource :event
	# load_and_authorize_resource :bracket, through: :event

	# load_and_authorize_resource :registration, through: :bracket, only: [:show, :index]
	load_and_authorize_resource :registration, through: :event
	
	# TODO: before action to load ages, belt, weights for new and edit
	# TODO: payments with strype
	# TODO: register directly from event and choose weightclass correspondingly

	def index
		@pagy, @registrations = pagy(@registrations, items: 10)
	end

	def show
	end
	
	def new
		# TODO: try to use options from collection
		find_weightclass
		# weightclasses = @event.weightclasses
		# @ages = weightclasses.pluck(:age).uniq
		
		# all_sexes = weightclasses.where(age: @age)
		# @sexes = all_sexes.pluck(:sex).uniq

		# all_belts =  all_sexes.where(sex: @sex)
		# @belts = all_belts.pluck(:belt).uniq
		
		# all_weights = all_belts.where(belt: @belt)
		# @weights = all_weights.pluck(:weight).uniq
	end

	# def edit
	# end

	def create
		chosen_weightclass = @event.weightclasses
													.by_age(params[:registration][:age])
													.by_sex(params[:registration][:sex])
													.by_belt(params[:registration][:belt])
													.by_weight(params[:registration][:weight]).first
		@registration.bracket = chosen_weightclass&.bracket
		if @registration.save
			redirect_to event_bracket_url(@event, @registration.bracket), notice: 'You registrated successfully.'
		else
			find_weightclass
			render :new, status: :unprocessable_entity
		end
	end

	# def update
	# 	if @event.update(event_params)
	# 		redirect_to event_bracket_path(@bracket), notice: 'Registration was successfully updated.'
	# 	else
	# 		render :edit, status: :unprocessable_entity
	# 	end
	# end

	def destroy
		@event.destroy
		redirect_to event_bracket_path(@bracket), notice: 'Registration was successfully destroyed.'
	end

	private
	def registration_params
		params.require(:registration).permit()
	end

	def find_weightclass
		weightclasses = @event.weightclasses
		@ages = weightclasses.pluck(:age).uniq
		@sexes = weightclasses.pluck(:sex).uniq
		@belts = weightclasses.pluck(:belt).uniq
		@weights = weightclasses.pluck(:weight).uniq
	end
end