require "test_helper"

class BracketTest < ActiveSupport::TestCase
  test "bracket scope has_registrations" do
    event1 = Event.find_by(name: "Event 1")    
    b1 = Bracket.create(event: event1)
    r1 = Registration.create(competitor: User.last, bracket: b1)
    r2 = Registration.create(competitor: User.first, bracket: b1)

    event2 = Event.find_by(name: "Event 2")
    b2 = Bracket.create(event: event2)
    r3 = Registration.create(competitor: User.second, bracket: b2)
    
    event3 = Event.find_by(name: "Event 3")
    b3 = Bracket.create(event: event3)

    assert_equal 2, event1.brackets.has_registrations.count
    assert_equal 1, event2.brackets.has_registrations.count
    assert_equal 0, event3.brackets.has_registrations.count
  end

  test "bracket scope weightclasses" do
    event1 = Event.find_by(name: "Event 1")    
    b1 = Bracket.create(event: event1)
    b2 = Bracket.create(event: event1)
    b3 = Bracket.create(event: event1)
    b4 = Bracket.create(event: event1)

    AdultWhiteMale77 =   b1.create_weightclass(age: "Adult", belt: "White", sex: "Male", weight: 77)
    AdultWhiteMale88 =   b2.create_weightclass(age: "Adult", belt: "White", sex: "Male", weight: 88)
    AdultWhiteFemale66 = b3.create_weightclass(age: "Adult", belt: "White", sex: "Female", weight: 60)
    AdultWhiteFemale70 = b4.create_weightclass(age: "Adult", belt: "White", sex: "Female", weight: 70)

    assert_equal 0, event1.brackets.with_weightclass(age: "Juvenile").count
    assert_equal 0, event1.brackets.with_weightclass(age: "Adult", belt: "Blue").count
    assert_equal 2, event1.brackets.with_weightclass(age: "Adult", belt: "White", sex: "Male").count
    assert_equal 1, event1.brackets.with_weightclass(weight: 70).count
  end
end
