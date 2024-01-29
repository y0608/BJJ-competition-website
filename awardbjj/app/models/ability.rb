# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event
    can :read, Bracket

    return unless user.present? # if we don't return here, the next line will throw an error if user is nil
    can :read, User, id: user.id
    
    return unless user.organizer?
    can [:create, :update, :destroy], Event, organizer_id: user.id
  end
end
