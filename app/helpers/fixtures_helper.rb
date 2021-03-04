require 'json'
require 'open-uri'
require 'nokogiri'

module FixturesHelper
  # Scraping club info sorted alphabetically, so that club_ids are updated each season
  def sorted_club_names
    base_url = 'https://www.premierleague.com/clubs'
    html = URI.open(base_url).read
    parsed_html = Nokogiri::HTML(html)
    nokogiri_objects = parsed_html.css(".indexInfo > .nameContainer > .clubName")
  
    club_arr = []
    nokogiri_objects.each { |object| club_arr << object.children.inner_text }
    club_arr
  end
  
  def map_id_to_club
    index_arr = (1..20).to_a 
    Hash[index_arr.zip(sorted_club_names)]
  end

  def get_fixtures
    clubs_with_id = map_id_to_club()
  
    # call FPL API for fixtures info
    url = 'https://fantasy.premierleague.com/api/fixtures/'
    request = URI.open(url).read
    request_hash = JSON.parse(request)
  
    fixture_details = [] 
  
    request_hash.flatten.each do |fixture|
      home = fixture["team_h"]
      away = fixture["team_a"]
      away_score = fixture["team_a_score"]
      home_score = fixture["team_h_score"]
      gameweek = fixture["event"]
      kickoff = fixture["kickoff_time"]
  
      fixture_details << { "gameweek" => gameweek, "home_team_id" => home, "away_team_id" => away, "home_team" => "#{clubs_with_id[home]}", "home_score" => home_score, "away_team" => "#{clubs_with_id[away]}", "away_score" => away_score, "kickoff_time" => kickoff }
    end
    fixture_details
  end
end