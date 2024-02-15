require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1920, 1080]
  Capybara.save_path = Rails.root.join('tmp', 'screenshots')
end