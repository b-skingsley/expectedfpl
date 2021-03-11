require 'open-uri'
require 'nokogiri'

namespace :club do
  desc "Scraping daily update from FBref.com for the clubs table"
  task daily_update: :environment do
    url = "https://fbref.com/en/comps/9/Premier-League-Stats"

    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)

    # Array containing all clubs in the order of their current position in the Premier League table
    teams = html_doc.search("table#results107281_home_away tbody tr")
    
    # This is the order of the FPL API (Leeds and Leicester have to be in this order)
    clubs = ["Arsenal", "Aston Villa", "Brighton", "Burnley", "Chelsea", "Crystal Palace", "Everton", "Fulham", "Leicester City", "Leeds United", "Liverpool", "Manchester City", "Manchester Utd", "Newcastle Utd", "Sheffield Utd", "Southampton", "Tottenham", "West Brom", "West Ham", "Wolves"]
    
    clubs.each_with_index do |club, fplid|
      teams.each do |team|
        if team.search("td[data-stat=squad] a").text === club
          fpl_club = Club.find_by(fplid: fplid + 1) # 1 has to be replaced with (fplid + 1)
          # update the relevant information
          fpl_club.number_of_games_at_home = team.search("td[data-stat=games_home]").text
          fpl_club.season_total_goals_scored_at_home = team.search("td[data-stat=goals_for_home]").text
          fpl_club.season_total_goals_conceded_at_home = team.search("td[data-stat=goals_against_home]").text
          fpl_club.number_of_games_away = team.search("td[data-stat=games_away]").text
          fpl_club.season_total_goals_scored_away = team.search("td[data-stat=goals_for_away]").text
          fpl_club.season_total_goals_conceded_away = team.search("td[data-stat=goals_against_away]").text
          # save changed to the club table
          fpl_club.save!
          # print success message
          puts "#{team.search('td[data-stat=squad] a').text} has been updated"
          # end inner loop if club has been found
          break
        end
      end
    end
  end
end
