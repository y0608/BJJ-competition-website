# frozen_string_literal: true

class Ability
  include CanCan::Ability
  
  # TODO: admin role

  def initialize(user)
    can :read, Event
    can :read, Bracket
    can :read, Registration
    can :read, User
    can :read, Match
    return unless user.present? # if we don't return here, the next line will throw an error if user is nil
    
    # TODO: can :mange, User, id: user.id (not sure how devise handles this)
    # can :read, User, id: user.id
    
    
    if user.organizer?
      can [:create, :update, :destroy], Event, organizer_id: user.id
      can [:add_scoreboard_values, :start_timer, :pause_timer], Match, bracket: { event: { organizer_id: user.id } }
      # TODO: edit, update, destroy registration
      # TODO: can create custom brackets, matches, and registrations
      # can [:create, :update, :destroy], Bracket, event: { organizer_id: user.id }
      # can [:create, :update, :destroy], Match, bracket: { event: { organizer_id: user.id } }
      # can [:destroy], Registration, event: { organizer_id: user.id }
    elsif user.competitor?
      can [:create, :new, :update, :destroy], Registration, competitor_id: user.id
    end
    
  end
end
