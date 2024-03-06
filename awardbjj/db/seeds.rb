# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "\n== Seeding the database with fixtures =="
# system("bin/rails db:fixtures:load")


# puts "\n== User fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=users")

# puts "\n== Event fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=events")

# puts "\n== Bracket fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=brackets")

# puts "\n== Weightclass fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=weightclasses")

# puts "\n== Entry fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=entries")

competitors = []
20.times do |i|
  u = User.create!(first_name: "Competitor",
    last_name: i,
    role: User.roles[:competitor],
    email: "competitor#{i}@gmail.com",
    password: "123456",
    password_confirmation: "123456",
  )

  u.confirm

  competitors << u
end

organizer1 = User.create!(
  organization_name: "Organization One",
  role: User.roles[:organizer],
  email: "organizer@gmail.com",
  password: "123456",
  password_confirmation: "123456"
)
organizer1.confirm


event1 = Event.create!(
  name: "Event One",
  game_type: Event.game_types[:no_gi],
  description: "Event One Description",
  start_at: Time.current + 1.month,
  end_at:   Time.current + 1.month + 1.day,
  location: "Sofia, Bulgaria",
  organizer: organizer1
)

(1..competitors.length).each do |i|
  if i <= 5
    Entry.create!(competitor: competitors[i], bracket: event1.brackets[0])
  elsif i < competitors.length
    Entry.create!(competitor: competitors[i], bracket: event1.brackets[1])
  end
end