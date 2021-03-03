# include ActionView::Helpers

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
Fixture.destroy_all
puts "Destroying all existing fixtures...\n____________________"
counter = 1
ApplicationController.helpers.get_fixtures.each do |fixture|
  unless fixture["gameweek"].nil? || fixture["kickoff_time"].nil?
    Fixture.create!(kickoff: fixture["kickoff_time"], gameweek: fixture["gameweek"].to_i, h_score: fixture["home_score"], a_score: fixture["a_score"], home_team_id: fixture["home_team_id"], away_team_id: fixture["away_team_id"])
    puts "Fixture #{counter} created."
    counter += 1
  end
end
