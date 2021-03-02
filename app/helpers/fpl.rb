require 'json'
require 'open-uri'

class PremierLeagueAPI
  BASE_URL = 'https://fantasy.premierleague.com/api/fixtures/'

  def query
    request = open(BASE_URL).read
    @request_hash = JSON.parse(request)
  end
  
  def self.fixtures
    @request_hash.each do |fixture|
      home_team = fixture["team_h"]
      home_team_score = fixture["team_h_score"]
      away_team = fixture["team_a"]
      away_team_score = fixture["team_a_score"]
      puts "#{home_team} - #{home_team_score} | #{away_team_score} - #{away_team}"
    end
  end
end
  