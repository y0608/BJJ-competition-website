require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase

  test "user can log in" do
    visit new_user_session_path

    fill_in "Email", with: "competitor1@gmail.com"
    fill_in "Password", with: "123456"

    save_screenshot("#{self.class.name}#{Time.now}.png")

    click_on "Log in"

    assert_selector "h1", text: "Welcome"
  end
end
