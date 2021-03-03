# require_relative "premier_league"

# Club.destroy_all
# puts "Destroyed all existing Clubs\n____________________"

# clubs_count = 0
# PremierLeague::CLUBS.each do |club|
#   Club.create!(name: club[:name], short_name: club[:short_name], form: club[:form])
#   clubs_count += 1
# end

# puts "#{clubs_count} clubs saved to DB\n__________________"

User.destroy_all
puts "Destroyed all existing Users\n____________________"
%w(ben@expectedfpl.com matt@expectedfpl.com mark@expectedfpl.com marcel@expectedfpl.com).each do |email|
  User.create!(email: email, password: 'password')
  puts "-- #{email} saved as a user"
end

puts "______________\nDB Seeding Complete"

# Fixtures
require_relative "../app/helpers/fixtures.rb"
