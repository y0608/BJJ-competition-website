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
system("bin/rails db:fixtures:load")


# puts "\n== User fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=users")

# puts "\n== Event fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=events")

# puts "\n== Bracket fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=brackets")

# puts "\n== Weightclass fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=weightclasses")

# puts "\n== Registration fixtures =="
# system("bin/rails db:fixtures:load FIXTURES=registrations")