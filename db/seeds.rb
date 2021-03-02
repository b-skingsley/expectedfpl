require_relative "premier_league"

Club.destroy_all
puts 'Destroyed all existing Clubs'

PremierLeague::CLUBS.each do |club|
  Club.create!(name: club[:name], short_name: club[:short_name], form: club[:form])
  puts "#{club[:name]} added to DB"
end
