# frozen_string_literal: true

class Ability
  include CanCan::Ability
  
  # TODO: admin role

  def initialize(user)
    can :read, Event
    can :read, Bracket
    can :read, Registration
    can :read, User

    return unless user.present? # if we don't return here, the next line will throw an error if user is nil
    
    # TODO: can :mange, User, id: user.id (not sure how devise handles this)
    can :read, User, id: user.id
    
    return unless user.organizer?
    can [:create, :update, :destroy], Event, organizer_id: user.id
  end
end
