require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "should create bracket and weightclass after creating event" do
  #   event = Event.new(name: "Test Event", description: "This is a test event.", start_at: Time.now, location: "Test Location", organizer_id: 172563265)
  #   event.save!

  #   assert_equal 1, event.brackets.count
  #   assert_equal 1, event.brackets.first.weightclasses.count
  # end
  # test "everyone should be able to read an event" do
  #   event = events(:event1)

  #   ability = Ability.new(nil)
  #   assert ability.can?(:read, event)
  # end

  # test "organizer should be able to create an event" do
  #   organizer = users(:organizer1)
  #   event = organizer.events.build(name: "Test Event", description: "This is a test event.")

  #   ability = Ability.new(organizer)
  #   assert ability.can?(:create, event)
  # end

  # test "competitor should not be able to create an event" do
  #   competitor= users(:competitor1)
  #   event = competitor.events.build(name: "Test Event", description: "This is a test event.")

  #   ability = Ability.new(competitor)
  #   assert ability.cannot?(:create, event)
  # end
end