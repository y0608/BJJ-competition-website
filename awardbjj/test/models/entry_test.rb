require "test_helper"

class EntryTest < ActiveSupport::TestCase
  # test "user can have a entry only for one normal and one open category per event"
  test "user can have one entry per event"
    event1 = Event.find_by(name: "Event 1")    
    b1 = Bracket.create(event: event1)
    b2 = Bracket.create(event: event1)

    r1 = Entry.create(competitor: User.last, bracket: b1)
    assert_fail Entry.create(competitor: User.last, bracket: b1)
    assert_fail Entry.create(competitor: User.last, bracket: b2)
  end 
end
