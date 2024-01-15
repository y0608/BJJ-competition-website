require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "everyone should be able to read an event" do
    event = events(:event1)

    ability = Ability.new(nil)
    assert ability.can?(:read, event)
  end

  test "organizer should be able to create an event" do
    organizer = users(:organizer1)
    event = organizer.events.build(name: "Test Event", description: "This is a test event.")

    ability = Ability.new(organizer)
    assert ability.can?(:create, event)
  end

  test "competitor should not be able to create an event" do
    competitor= users(:competitor1)
    event = competitor.events.build(name: "Test Event", description: "This is a test event.")

    ability = Ability.new(competitor)
    assert ability.cannot?(:create, event)
  end
end