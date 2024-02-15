require "application_system_test_case"

class BracketsTest < ApplicationSystemTestCase
  test "user can view brackets" do
    event = Event.all.first
    visit event_brackets_url(event)
    save_screenshot("#{self.class.name}#{Time.now}.png")
    assert_selector "a", text: "See Bracket"
  end

  test "user can view bracket before match creation" do
    event = Event.all.first
    bracket = event.brackets.with_weightclass(age: "Adult", sex: "Male", belt: "White", weight: 77).first
    visit event_bracket_url(event, bracket)
    save_screenshot("#{self.class.name}#{Time.now}.png")
    assert_selector "h1", text: "Adult Male White 77.0"
  end

  test "user can view bracket after match creation" do
    event = Event.all.first
    bracket = event.brackets.with_weightclass(age: "Adult", sex: "Male", belt: "White", weight: 77).first
    bracket.create_matches
    visit event_bracket_url(event, bracket)
    save_screenshot("#{self.class.name}#{Time.now}.png")
    assert_selector "h1", text: "Adult Male White 77.0"
    assert_selector "h2", text: "Final"
  end

  # test "user can view bracket after match ended(winners announced)" do
  #   event = Event.all.first
  #   bracket = event.brackets.with_weightclass(age: "Adult", sex: "Male", belt: "White", weight: 77).first
  #   bracket.create_matches

  #   bracket.matches.first.update(winner: bracket.matches.first.competitor1)
  #   bracket.set_winners

  #   visit event_bracket_url(event, bracket)
  #   save_screenshot("#{self.class.name}#{Time.now}.png")
  #   assert_selector "h1", text: "Adult Male White 77.0"
  #   assert_selector "h2", text: "Final"
  #   assert_selector "h2", text: "Winners:"
  # end
end
