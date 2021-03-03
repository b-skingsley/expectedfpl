require_relative "../app/helpers/premier_league"

#  ------------ Destroying Records--------------------
puts "Destroying all existing Footballers...\n____________________"
Footballer.destroy_all
puts "All existing Footballers Destroyed\n____________________\n"

Fixture.destroy_all
puts "Destroying all existing fixtures...\n____________________"

puts "Destroying all existing Clubs...\n____________________"
Club.destroy_all
puts "All existing Users Destroyed\n____________________\n"

puts "Destroying all existing Users...\n____________________"
User.destroy_all
puts "All existing Users Destroyed\n____________________\n"

# ------------- User Seeding -----------------

puts "Seeding Users...\n____________________"
users_count = 0
%w(ben@expectedfpl.com matt@expectedfpl.com mark@expectedfpl.com marcel@expectedfpl.com).each do |email|
  User.create!(email: email, password: 'password', admin: true)
  users_count += 1
end
puts "#{users_count} Users seeded\n____________________\n"

# ------------- Club Seeding -----------------

puts "Seeding Clubs...\n____________________"
clubs_count = 0
PremierLeague::CLUBS.each do |club|
  Club.create!(
    name: club[:name],
    short_name: club[:short_name],
    form: club[:form],
    fplid: club[:fplid]
    )
  clubs_count += 1
end
puts "#{clubs_count} clubs seeded\n__________________\n"

# ------------- Footballers Seeding -----------------

puts "Seeding Footballers...\n____________________"
footballer_count = 0

url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
response = URI.open(url).read
deserialized = JSON.parse(response)

deserialized['elements'].each do |footballer|

  case footballer['element_type']
  when 1 then position = 'GK'
  when 2 then position = 'DEF'
  when 3 then position = 'MID'
  when 4 then position = 'FWD'
  else
    position = 'UNKNOWN'
  end

  club = Club.find_by(fplid: footballer['team'])

  Footballer.create!(
    first_name: footballer['first_name'],
    last_name: footballer['second_name'],
    web_name: footballer['web_name'],
    price: footballer['now_cost'],
    position: position,
    total_points: footballer['total_points'],
    goals: footballer['goals_scored'],
    assists: footballer['assists'],
    clean_sheets: footballer['clean_sheets'],
    yellow_cards: footballer['yellow_cards'],
    red_cards: footballer['red_cards'],
    saves: footballer['saves'],
    goals_conceded: footballer['goals_conceded'],
    own_goals: footballer['own_goals'],
    penalties_saved: footballer['penalties_saved'],
    penalties_missed: footballer['penalties_missed'],
    bonus: footballer['bonus'],
    bps: footballer['bps'],
    club: club,
    fplid: footballer['id']
    )
  footballer_count += 1
end
puts "#{footballer_count} footballers seeded\n__________________\n"

# --------------------------------------------------

# - Fixtures

ApplicationController.helpers.get_fixtures.each do |fixture|
  home_team_id = Club.find_by(name: fixture["home_team"])[:id]
  away_team_id = Club.find_by(name: fixture["away_team"])[:id]
  if fixture["gameweek"] || fixture["kickoff_time"]
    Fixture.create!(kickoff: fixture["kickoff_time"], gameweek: fixture["gameweek"].to_i, h_score: fixture["home_score"].to_i, a_score: fixture["a_score"].to_i, home_team_id: home_team_id, away_team_id: away_team_id)
  end
end

puts "DB Seeding Complete"
